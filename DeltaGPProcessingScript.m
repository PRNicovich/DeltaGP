% Using Laurdan and mCherry data, register, phasor transform,  and colocalize (Lo/Ld vs mCherry
% Intensity)
%
% The following folder structure is assumed:
% [Data Folder]
%   |
%   |-[PM]
%      |
%      |-[MMDDYYYY]
%         |
%         |-[CorrectedMasks]
%         |-[GP]
%         |-[Spectral]
%   |
%   |-[Whole Cell]
%      |
%      |-[MMDDYYYY]
%         |
%         |-[CorrectedMasks]
%         |-[GP]
%         |-[Spectral]
%
% The routine will look in [Data Folder] (given in variable folderName) for
% data, will look in folder [CorrectedMasks] for masks under [MMDDYY],
% then put results in the [GP] folder parallel to [CorrectedMasks] and
% under [MMDDYYYY].
%
% Specify which [CorrectedMasks] folders to use and script will find data
% (in parent folder to [PM] and [Whole Cell]) and save data in GP folder
% parallel to [CorrectedMasks].
%
% CorrectedMask files can be made in ImageJ or other program, or created
% here on the first pass.  File does not have to exist, but specify it in
% the form described above so the LSM that does have to exist can be found.
%  CorrectedMask file will then be created.
% 
% Fitting Laurdan spectrum to gamma fitting done in the style of 
% Sezgin, Waithe, de la Serna, and Eggeling,
% Chemphyschem, DOI: 10.1002/cphc.201402794
% Uses parallel toolbox to speed up multiple curve fitting operations.






masksFolders = {'D:\Dropbox\Proposals\DeltaGP\Figure1Prep\whole cells analysed\29.06.2016\CorrectedMasks'};

% Run masks only or do fitting? Set to 1 if GP fitting is to be skipped.
RunMasksOnly = 0;

% Input data filter
filterType = 'none'; % 'median' or 'gaussian' or 'none'
MedianfilterNhood = [1 1];
GaussianSigma = .5;

% Mask Manipulation
mCherryMaskDilate = 1; % How much to dilate detected cell membrane. Determins the outside edge.

mCherryMaskErode = 4; % How much to erode dilated cell membrane.
% Sum of dilate and erode is ~ width of allowed membrane region.
% in pixels
% For PM ROI add number, for whole cell leave the numer will not be taken into
% account

AutoRegister = 0; % Attempt to automatically register mCherry and Laurdan images

fitMethod = 'gammaVariate'; % 'gammaVariate' or 'gaussian'

LoWavelength = 440; % Wavelength for ordered phase
LdWavelength = 490; % Wavelength for disordered phase
FitRsquaredThreshold = 0.5; % Threshold for rsqrd value for GP fit

% Number of random samples to make for GP/mCherry comparison
NBootstrapSamples = 1000;
PercentileToPlot = [0.5 99.5]; % [0.5 99.5] covers 99% of data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End User Inputs and Begin processing

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Start parallel toolbox
close all
import java.util.*;
if verLessThan('matlab', 'R2014a')
    pool = matlabpool('size');
    if pool == 0
        matlabpool('open');
    end
else
    gcp
end

ZoomFolders = ~cellfun(@isempty, (strfind(masksFolders, 'Zoom')));
NotZoomFolders = ~ZoomFolders;
ZoomFolders = find(ZoomFolders);
NotZoomFolders = find(NotZoomFolders);

% Get list of unique data folders
% 22052015
dataFolders = cell(length(masksFolders), 1);
for k = 1:length(masksFolders)
    folderHere = masksFolders{k};
    fsplit = strsplit(masksFolders{k}, '\');
    if isempty(fsplit{1})
        dataFolders{k} = strcat('\', strjoin(fsplit(1:end-3), '\'));
    else
        dataFolders{k} = strcat('', strjoin(fsplit(1:end-3), '\'));
    end
end
dataFolders = unique(dataFolders);

% folderArray{1} = ZoomFolders;
% folderArray{2} = NotZoomFolders;
% 
% if ~isempty(ZoomFolders)
%     ZoomDataFolder = strfind(masksFolders{ZoomFolders(1)}, 'PM');
%     if isempty(ZoomDataFolder)
%         ZoomDataFolder = strfind(lower(masksFolders{ZoomFolders(1)}), 'whole');
%     end
%     
%     ZoomDataFolder = masksFolders{ZoomFolders(1)}(1:(ZoomDataFolder-1));
% end
% 
% if ~isempty(NotZoomFolders)
%     NotZoomDataFolder = strfind(masksFolders{NotZoomFolders(1)}, 'PM');
%     if isempty(NotZoomDataFolder)
%         NotZoomDataFolder = strfind(lower(masksFolders{NotZoomFolders(1)}), 'whole');
%     end
%     
%     NotZoomDataFolder = masksFolders{NotZoomFolders(1)}(1:(NotZoomDataFolder-1));
% end


% Phasor peak localization filter
% gausSigma = 2;

% Specify method for choosing which calibration results to use
% 'MaxRadius' - estimate phasor extrema from mCherry+Laurdan LSM file
% directly (no reference sample)
% 'SpecifyDate' - Use a particular PooledPhasors_Table.txt file, specified
% by dataSetDateString
% 'IncludedOnly - Use a particular PooledAvgPhasorResults...dat file
% specified by dataSetDateString
% dataSelectionMethod = 'IncludedOnly'; %'MaxRadius', 'SpecifyDate', 'IncludedOnly'
% dataSetDateString = 'PooledAvgPhasorResults24042015 excluded'; % Specify date string present in file name ('SpecifyDate' and 'IncludedOnly' options)

% Method for choosing autofluoresence points
% AutofluorSelectionMethod = 'AutoSelect'; % 'ReadFromFile' or 'AutoSelect'


plotColors =  [1    0.1569    0.5765; ...
    0.2039    0.6667    0.8627; ...
    1    0.2510    0.3922; ...
    0.3451    0.3373    0.8392; ...
    .750000    0.2314    0.0882; ...
    0    0.4784    1.0000; ...
    1.0000    0.1765    0.3333; ...
    0.3529    0.7843    0.9804; ...
    1.0000    0.5843         0; ...
    1.0000    0.8000         0];

% HNV = 1; % Harmonic to use

% nRadialDivisions = 12;
% markerSize = 12; % Phasor plot marker size



% phasorImgDisplayRange = [0 1];
gpImgDisplayRange = [-1 1];

% fileList = dir(strcat(dataFolder, '\*.txt'));
plotHSV = rgb2hsv(plotColors);
plotHSV(:,2) = plotHSV(:,2)/2;
plotInd = hsv2rgb(plotHSV);

if strcmp(filterType, 'gaussian');
    gFilt = fspecial('gaussian', 11, GaussianSigma);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Loop over Zoom/not zoom

% for ZoomNotZoom = 1:2
%     
%     switch ZoomNotZoom
%         case 1
%             folderName = ZoomDataFolder;
%         case 2
%             folderName = NotZoomDataFolder;
%     end



for fNumber = 1:length(dataFolders)
    
    folderName = dataFolders{fNumber};
    
    DataIsZoom = ~isempty(strfind(lower(folderName), 'zoom'));
    
    %%%%%%%%%%%%
    % Load Image data
    
    lsmList = ls(strcat(folderName, '\*.lsm'));
    
    if isempty(lsmList)
        disp('No LSM files found in designated folder.  Check folder name and spelling.')
        
    else
        
        
        
        lsmExpts = unique(lsmList(:,1));
        
        sampleNos = str2double(cellstr(lsmList(:, [1])));
        acqNos = zeros(size(lsmList, 1), 1);
        numsEndKeep = zeros(size(lsmList, 1), 1);
        for k = 1:length(acqNos)
            numsEnd = strfind(lsmList(k, :), '-');
            acqNos(k) = str2double(lsmList(k, 3:(numsEnd(1)-1)));
            numsEndKeep(k) = numsEnd(1)-1;
        end
        
        sampleIDNums = [sampleNos acqNos];
        sampleIDNums = unique(sampleIDNums, 'rows');
        
        % for fN = 9:size(sampleIDNums, 1);
        for fN = 1:size(sampleIDNums, 1)
            
            leadString = sprintf('%d.%d-', sampleIDNums(fN, 1), sampleIDNums(fN, 2));
            lsmFile = deblank(lsmList(strncmp(cellstr(leadString), lsmList, numel(leadString)) & cellfun(@isempty, (strfind(lower(cellstr(lsmList)), 'fingerprint'))),:));
            %fN
            fileName = fullfile(folderName, lsmFile);
            
            % Load .lsm file
            data = bfopen(fileName);
            
            DataIn = zeros(size(data{1}{1,1},1), size(data{1}{1,1},2), size(data{1}, 1));
            for k = 1:size(data{1}, 1)
                
                if strcmp(filterType, 'median');
                    DataIn(:,:,k) = medfilt2(data{1}{k,1}, MedianfilterNhood);
                elseif strcmp(filterType, 'gaussian');
                    DataIn(:,:,k) = imfilter(data{1}{k,1}, gFilt);
                elseif strcmp(filterType, 'none');
                    DataIn(:,:,k) = data{1}{k,1};
                else
                    merror('Filter type not supported.  Please choose "median", "gaussian", or "none"');
                end
                
            end
            
            % Pull out the wavelength channels desired
            keys = data{2}.keySet();
            iterator = keys.iterator();
            Nkeys = keys.size();
            
            keyHold = cell(Nkeys, 1);
            
            m = 0;
            
            %iterate over all keys
            while iterator.hasNext()
                
                key=iterator.next();
                val=data{2}.get(key);
                
                keyHold{m+1} = key;
                
                m = m+1;
            end
            
            startKey = keyHold{~(cellfun(@isempty, (strfind(keyHold, 'SPI Wavelength Start'))))};
            endKey = keyHold{~(cellfun(@isempty, (strfind(keyHold, 'SPI Wavelength End'))))};
            
            spectrumStart = data{2}.get(startKey);
            spectrumEnd = data{2}.get(endKey);
            
            nChannels = data{2}.get(keyHold{~(cellfun(@isempty, (strfind(keyHold, 'DimensionChannels'))))});
            
            spectrum = linspace(spectrumStart, spectrumEnd, nChannels+1); % Spectrum edges
            spectrum = (spectrum + circshift(spectrum, [1, 1]))/2;
            spectrum(1) = []; % Spectrum centers
            LoChannel = (LoWavelength - spectrum(1))/mean(diff(spectrum)) + 1;
            LdChannel = (LdWavelength - spectrum(1))/mean(diff(spectrum)) + 1;
            
            
            
            %%%%%%%%
            
            mCherryName = deblank(lsmList(strncmp(cellstr(leadString), lsmList, numel(leadString)) & ~cellfun(@isempty, (strfind(lower(cellstr(lsmList)), 'fingerprint'))),:));
            
            mCfileName = fullfile(folderName, mCherryName);
            
            % Load .lsm file
            data = bfopen(mCfileName);
            
            DataCherry = zeros(size(data{1}{1,1},1), size(data{1}{1,1},2), size(data{1}, 1));
            for k = 1:size(data{1}, 1)
                
                if strcmp(filterType, 'median');
                    DataCherry(:,:,k) = medfilt2(data{1}{k,1}, MedianfilterNhood);
                elseif strcmp(filterType, 'gaussian');
                    DataCherry(:,:,k) = imfilter(data{1}{k,1}, gFilt);
                elseif strcmp(filterType, 'none');
                    DataCherry(:,:,k) = data{1}{k,1};
                else
                    merror('Filter type not supported.  Please choose "median", "gaussian", or "none"');
                end
                
            end
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Loop over PM, Whole cell masks
            for PW = 1:2
                
                switch PW
                    case 1
                        searchString = 'PM';
                    case 2 
                        searchString = 'whole';
                end

                if DataIsZoom == 1;
                    ZoomSearchString = 'Zoom';
                
                    fAHere = find(~cellfun(@isempty, strfind(masksFolders, folderName)) & ...
                        ~cellfun(@isempty, strfind(lower(masksFolders), lower(searchString))) & ...
                        ~cellfun(@isempty, strfind(lower(masksFolders), lower('Zoom'))));
                
                else
                    
                    fAHere = find(~cellfun(@isempty, strfind(masksFolders, folderName)) & ...
                        ~cellfun(@isempty, strfind(lower(masksFolders), lower(searchString))) & ...
                        cellfun(@isempty, strfind(lower(masksFolders), lower('Zoom'))));
                    
                end
                
%                 fAHere = folderArray{ZoomNotZoom}(PW);
                
                if ~isempty(fAHere)

                MaskSaveName = fullfile(masksFolders{fAHere}, strcat(lsmFile(1:end-4), '_MaskImg.tif'));
                
                lastMaskSlash = strfind(masksFolders{fAHere}, '\');
                if lastMaskSlash(end) == numel(masksFolders{fAHere})
                    lMs = lastMaskSlash(end-1);
                else
                    lMs = lastMaskSlash(end);
                end
                
                parentFolderToMask = masksFolders{fAHere}(1:lMs);
                figFileName = fullfile(parentFolderToMask, 'GP', strcat(lsmFile(1:end-4), '_figOutGPVal.png'));
                cumDataFileName = fullfile(parentFolderToMask, 'GP', strcat(lsmFile(1:end-4), '_cumDistGPVal.txt'));
                mCherryvsGPFileName = fullfile(parentFolderToMask, 'GP', strcat(lsmFile(1:end-4), '_mCherryVsGPValue.txt'));
                
                %%%%%%%%%%%%%%%%%%%%%%%%
                % Mask based on sum image of mCherry
                sumImg = sum(DataIn, 3);
                sumCherry = sum(DataCherry, 3);
                
                %%%%%%%%%%%%%%%%%%%%
                % See if mask exists
                %         MaskSaveName = fullfile(folderName, strcat(lsmFile(1:end-4), '_MaskImg.tif'));
                if exist(MaskSaveName, 'file') == 2
                    % load existing maskFile
                    cherryMask = imread(MaskSaveName);
                    
                    if size(cherryMask, 3) > 1
                        cherryMask = sum(cherryMask(:,:,1:3), 3);
                    end
                    
                    cherryMask = cherryMask == max(cherryMask(:));
                    
                    cherryMaskTotal = cherryMask;
                    
                    maskFound = 1;
                    
                else
                    
                    % Pull out threshold value for mCherry channel and make mask
                    cherryThresh = max(sumCherry(:)) * graythresh(sumCherry/max(sumCherry(:)));
                    cherryMask = sumCherry > cherryThresh;
                    cherryMask = bwmorph(cherryMask, 'close');
                    cherryMask = imfill(cherryMask, 'holes');
                    %     cherryMask = bwmorph(cherryMask, 'open');
                    cherryMask = bwmorph(cherryMask, 'dilate', mCherryMaskDilate);
                    
                    % Pad out edge value so that erode action below doesn't end up
                    % capturing area of cells along edge of image frame
                    padDim = mCherryMaskErode + mCherryMaskDilate;
                    if isinf(padDim)
                        padDim = 0;
                    end
                    
                    PadCherryMask = padarray(cherryMask, [padDim, padDim], ...
                        'replicate'); % Extend out regions to edges
                    cherryMaskInner = bwmorph(PadCherryMask, 'erode', mCherryMaskErode + mCherryMaskDilate);
                    cherryMaskInner = cherryMaskInner((padDim + 1):(end-(padDim)), ...
                        (padDim + 1):(end-(padDim)));
                    
                    if PW == 1
                        cherryMaskTotal = cherryMask & ~cherryMaskInner;
                    else
                        cherryMaskTotal = cherryMask;
                    end
                    
                    maskFound = 0;
                    
                end
                
                % Fix so the holes in the inside get filled
                % Autofluor detect - on whole cell? Or just membrane?
                % G/P ratio as done by Eggeling?
                % All done.
                
                %%%%%%%%%%%%%%%%%%
                % Align channels
                
                [optimizer,metric] = imregconfig('multimodal');
                optimizer.InitialRadius = optimizer.InitialRadius/3.5;
                regTform = imregtform(sumCherry, sumImg, 'translation', optimizer, metric);
                
                if AutoRegister == 1
                    mCherryRegistered = imwarp(sumCherry, regTform, 'OutputView',imref2d(size(cherryMaskTotal)));
                
                    if (maskFound == 0) && (AutoRegister == 1)
                        cherryMask = imwarp(cherryMaskTotal, regTform, 'OutputView', imref2d(size(cherryMask)));
                        cherryMaskInner = imwarp(cherryMaskTotal, regTform, 'OutputView', imref2d(size(cherryMaskInner)));
                        cherryMaskTotal = imwarp(cherryMaskTotal, regTform, 'OutputView', imref2d(size(cherryMaskTotal)));

                        % Save file to disk
                        imwrite(cherryMaskTotal, MaskSaveName, 'TIFF', 'Compression', 'none');

                    end
                    
                else
                    
                    mCherryRegistered = sumCherry;
                    
                    if (maskFound == 0)
                        
                        cherryMask = cherryMaskTotal;
                        cherryMaskInner = cherryMaskTotal;
                         
                        imwrite(cherryMaskTotal, MaskSaveName, 'TIFF', 'Compression', 'none')
                        
                    end
                    
                end
                
                mCherryInts = mCherryRegistered(cherryMaskTotal);
                maskPixels = find(cherryMaskTotal);
                
                %     cherryBorder = bwboundaries(cherryMask);
                % 	cherryBorderInner = bwboundaries(cherryMaskInner);
                cherryBorderTotal = bwboundaries(cherryMaskTotal);
                
                
                
                if RunMasksOnly ~= 1
                    %%%%%%%%%%%%%
                    % Calculate GP values for the pixels inside the masked region
                    
                    DataGP = reshape(DataIn(repmat(cherryMaskTotal, [1 1 size(DataIn, 3)])), [], size(DataIn, 3));
                    
                    
                    ClassicLoLdValue = (DataGP(:,round(LoChannel)) - DataGP(:,round(LdChannel)))./(DataGP(:,round(LoChannel)) + DataGP(:,round(LdChannel)));
                    
                    % dataOut = [GPValue, RsquaredValue]; N x 2 where N =
                    % number of ON pixels in mask
                    dataOut = GPValueFromZeissSpectralData(DataGP, LoChannel, LdChannel, fitMethod);
                    
                    maskPixels((dataOut(:,2) < FitRsquaredThreshold) | isnan(dataOut(:,1))) = [];
                    mCherryInts((dataOut(:,2) < FitRsquaredThreshold) | isnan(dataOut(:,1))) = [];
                    dataOut((dataOut(:,2) < FitRsquaredThreshold) | isnan(dataOut(:,1)), :) = [];
                    ClassicLoLdValue((dataOut(:,2) < FitRsquaredThreshold) | isnan(dataOut(:,1)), :) = [];
                    
                    
                    remakeMask = zeros(size(cherryMaskTotal, 1), size(cherryMaskTotal, 2));
                    remakeMask(maskPixels) = 1;
                    
                    
                    
                    %%%%%%%%%%%
                    % Generate axes for plotting
                    figure(8)
                    clf(8)
                    phasImgAxes = axes('Parent', 8);
                    
                    figure(5)
                    clf(5)
                    specAxes = axes('Parent', 5);
                    
                    figure(9)
                    clf(9)
                    regAxes = axes('Parent', 9);
                    
                    figure(11)
                    clf(11)
                    phasorAx = axes('Parent', 11);
                    
                    figure(10)
                    clf(10)
                    colocAxes = axes('Parent', 10);
                    
                    %%%%%%%%%%%%
                    % Plot GP values
                    
                    gpHistVect = linspace(gpImgDisplayRange(1), gpImgDisplayRange(2), 100);
                    gpHist = histc(dataOut(:,1), gpHistVect);
                    gpBars = bar(gpHistVect, gpHist, 1, 'facecolor', (plotColors(6, :)), ...
                        'Parent', phasorAx, 'edgecolor', 0.8*plotColors(6, :));
                    set(phasorAx, 'XLim', gpImgDisplayRange, 'box', 'on');
                    xlabel(phasorAx, 'GP Value'); ylabel(phasorAx, 'Frequency');
                    drawnow;
                    
                    %%%%%%%%%%%%%
                    % Generate image plots
                    
                    % Show registration image
                    cla(regAxes);
                    axes(regAxes);
                    pairImg = imshowpair(mCherryRegistered, sumImg);
                    drawnow;
                    set(pairImg, 'Parent', regAxes);
                    set(regAxes, 'NextPlot', 'add', 'YDir', 'reverse');
                    axis(regAxes, 'image');
                    set(regAxes, 'XTick', [], 'YTick', []);
                    
                    % Make this a single plot command for all border pixels.  This is
                    % needed since mask can be a single image loaded from disk
                    for k = 1:length(cherryBorderTotal)
                        plot(regAxes, cherryBorderTotal{k}(:,2), cherryBorderTotal{k}(:,1), 'w');
                    end
                    set(regAxes, 'NextPlot', 'replace');
                    
                    NChannels = size(DataIn, 3);
                    
                    % Make spectral image, similar to Zen
                    CMapVect = jet(NChannels);
                    RedCMap = (reshape(ones(size(DataIn, 1)*size(DataIn, 2), 1)*CMapVect(:,1)', ...
                        [size(DataIn, 1), size(DataIn, 2), NChannels]));
                    GreenCMap = (reshape(ones(size(DataIn, 1)*size(DataIn, 2), 1)*CMapVect(:,2)', ...
                        [size(DataIn, 1), size(DataIn, 2), NChannels]));
                    BlueCMap = (reshape(ones(size(DataIn, 1)*size(DataIn, 2), 1)*CMapVect(:,3)', ...
                        [size(DataIn, 1), size(DataIn, 2), NChannels]));
                    
                    RedVals = DataIn.*RedCMap;
                    GreenVals = DataIn.*GreenCMap;
                    BlueVals = DataIn.*BlueCMap;
                    
                    SpectralImg = cat(3, sum(RedVals, 3), sum(GreenVals, 3), sum(BlueVals, 3));
                    SpectralImg(:,:,1) = 255*SpectralImg(:,:,1)/max(SpectralImg(:));
                    SpectralImg(:,:,2) = 255*SpectralImg(:,:,2)/max(SpectralImg(:));
                    SpectralImg(:,:,3) = 255*SpectralImg(:,:,3)/max(SpectralImg(:));
                    
                    SpectralImg = uint8(SpectralImg);
                    
                    cla(specAxes);
                    image(SpectralImg, 'Parent', specAxes)
                    axis(specAxes, 'image');
                    set(specAxes, 'XTick', [], 'YTick', []);
                    
                    %%%%%%%%%%%%%%%%%%%
                    % Pixel-by-pixel phasor plot
                    disorderToDisplay = zeros(size(DataIn, 1), size(DataIn, 2));
                    %     disorderToDisplay(cherryMask) = LoOverLd;
                    disorderToDisplay(maskPixels) = dataOut(:,1);
                    %     disorderToDisplay(isnan(disorderToDisplay)) = 0;
                    %     disorderToDisplay(disorderToDisplay > diff(phasorImgDisplayRange)) = diff(phasorImgDisplayRange);
                    
                    
                    
                    %     disRGB = Vector2Colormap((disorderToDisplay - min(gpImgDisplayRange(:)))/diff(gpImgDisplayRange(:)), 'jet').*Vector2Colormap(sumImg/max(sumImg(:)), 'gray');
                    
                    axes(phasImgAxes);
                    sumImgImg = (Vector2Colormap(sumImg/max(sumImg(:)), 'gray'));
                    disorderImg = reshape((Vector2Colormap_setscale(disorderToDisplay, 'jet', gpImgDisplayRange)),[size(sumImgImg, 1)*size(sumImgImg, 2), 3]);
                    disorderOverlayImg = reshape(sumImgImg, [size(sumImgImg, 1)*size(sumImgImg, 2), 3]);
                    disorderOverlayImg(maskPixels, :) = disorderImg(maskPixels, :);
                    disorderOverlayImg = reshape(disorderOverlayImg, [size(sumImgImg, 1), size(sumImgImg, 2), 3]);
                    imgOverlayHand = image(disorderOverlayImg);
                    set(imgOverlayHand, 'parent', phasImgAxes);
                    set(phasImgAxes, 'Nextplot', 'add');
                    %     disorderImg = imagesc(disorderToDisplay, gpImgDisplayRange);
                    %     set(disorderImg, 'Parent', phasImgAxes, 'AlphaData', remakeMask);
                    
                    axis(phasImgAxes, 'image')
                    set(phasImgAxes, 'XTick', [], 'YTick', []);
                    c = colorbar('Peer', phasImgAxes);
                    ylabel(c, 'GP Value', 'FontSize', 12);
                    set(c, 'YTick', 0:8:64);
                    set(c, 'YTickLabel', num2str(((0:8:64)*(diff(gpImgDisplayRange)/64) - 1)'));
                    set(c, 'FontSize', 10);
                    
                    % Calculate Spearman coefficient for Lo/(Lo+Ld) value and the mCherry
                    % intensity
                    
                    [rho, pval] = corr(dataOut(:,2), mCherryInts, 'Type', 'Spearman');
                    
                    
                    
                    figure()
                    
                    colocAxes = dscatter(dataOut(:,1), mCherryInts);
                    xlabel(colocAxes, 'GP Value');
                    ylabel(colocAxes, 'mCherry Int');
                    set(colocAxes, 'XLim', gpImgDisplayRange);
                    
                    
                    set(get(colocAxes, 'Parent'), 'NextPlot', 'add');
                    
                    cumSumFigure = figure(12);
                    clf(cumSumFigure);
                    cumSumAxes = axes('YAxisLocation', 'Right', 'Parent', cumSumFigure, 'NextPlot', 'add');
                    
                    % Add in cumulative distribution totals
                    histVect = linspace(-1, 1, 100);
                    
                    [a, b] = histc(dataOut(:,1), histVect);
                    cdfVal = zeros(numel(histVect), 2);
                    mC = mCherryInts - min(mCherryInts(:)); % Values of the mCherry intensity at valid points, minus the background (lowest) value
                    for hv = 1:numel(histVect)
                        cdfVal(hv, :) = [histVect(hv), sum(mC(b == hv))];
                    end
                    cdfVal(:,2) = cumsum(cdfVal(:,2));
                    cdfVal(:,2) = cdfVal(:,2)/max(cdfVal(:,2));
                    cdfInfPtEst = find(abs(cdfVal(:,2) - .5) == min(abs(cdfVal(:,2) - .5)), 1, 'first');
                    try
                        % Interpolate to find exact inflection point
                        cdfInfPt = interp1(cdfVal((cdfInfPtEst-2):(cdfInfPtEst+2),2), cdfVal((cdfInfPtEst-2):(cdfInfPtEst+2),1), 0.5);
                    catch
                        % Not a unique solution, so take the estimated
                        % value instead of the interpolated value
                        cdfIntPt = cdfVal(cdfInfPtEst,1);
                    end
                    
                    
                    %%%%%%%%%%%%%%%%%%%%%%%
                    % 21/5/15 addition - bootstrap GP + mCherry distribution to
                    % see if mCherry-tagged protein favors Lo or Ld areas
                    
                    randMatrix = cell2mat(arrayfun(@(dummy) randperm(numel(mC)), 1:NBootstrapSamples, 'UniformOutput', false)')';
                    mCRandomized = mC(randMatrix); % Randomize mCherry distribution

                    cdfRand = zeros(numel(histVect), NBootstrapSamples);
                    for hv = 1:numel(histVect)
                        for m = 1:NBootstrapSamples
                            cdfRand(hv, m) = sum(mCRandomized(b == hv, m));
                        end
                    end
                    cdfRand = cumsum(cdfRand);
                    cdfRand = cdfRand/max(cdfRand(:));
                    
                    PercentileCurves = prctile(cdfRand, PercentileToPlot, 2);
                    MeanCDFCurve = mean(cdfRand, 2);
                    
                    cdfMeanInfPtEst = find(abs(MeanCDFCurve - .5) == min(abs(MeanCDFCurve - .5)), 1, 'first');
                    try
                        cdfMeanIntPt = interp1(MeanCDFCurve((cdfMeanInfPtEst-2):(cdfMeanInfPtEst+2)), ...
                            cdfVal((cdfMeanInfPtEst-2):(cdfMeanInfPtEst+2),1), 0.5);
                    catch
                        cdfIntPt = MeanCDFCurve(cdfMeanInfPtEst,1);
                    end
                    
                    cdfPctileInfPtEst = zeros(1,2);
                    cdfPctileIntPt = zeros(1,2);
                     for pctCrv = 1:2
                        cdfPctileInfPtEst(pctCrv) = find(abs(PercentileCurves(:,pctCrv) - .5) == min(abs(PercentileCurves(:,pctCrv) - .5)), 1, 'first');
                        try
                            
                            cdfPctileIntPt(pctCrv) = interp1(PercentileCurves((cdfMeanInfPtEst-2):(cdfMeanInfPtEst+2), pctCrv), ...
                                cdfVal((cdfMeanInfPtEst-2):(cdfMeanInfPtEst+2),1), 0.5);
                            
                        catch 
                            cdfPctileIntPt(pctCrv) = PercentileCurves(cdfPctileInfPtEst(pctCrv), pctCrv);
                        end
                    end
                    
                    cdfInfPointPref(1) = cdfInfPt - cdfMeanIntPt;
                    cdfInfPointPref(2:3) = cdfMeanIntPt - cdfPctileIntPt;
                    
                    %%%%%%%%%%%%%%%%%%%%%%%%%%
                    
                    plot(cumSumAxes, cdfVal(:,1), cdfVal(:,2), 'k', 'LineWidth', 2);
                    plot(cumSumAxes, [cdfInfPt cdfInfPt], ...
                        [0 0.5], 'k:', 'LineWidth', 2);
                    plot(cumSumAxes, [cdfInfPt 1], ...
                        [0.5 0.5], 'k:', 'LineWidth', 2);
                    set(cumSumAxes, 'color', 'none')
                    set(cumSumAxes, 'XTick', [], 'YTick', 0:.2:1)
                    set(cumSumAxes, 'YLim', [0 1])
                    ylabel(cumSumAxes, 'Cumulative Distribution of mCherry Intensity');
                    
                    %%%%%%%%%%%%%%%%% Add in bootstrapped curves
                    set(cumSumAxes, 'NextPlot', 'add');
                    plot(cumSumAxes, cdfVal(:,1), MeanCDFCurve, 'r');
                    plot(cumSumAxes, cdfVal(:,1), PercentileCurves, 'r:');
                    set(cumSumAxes, 'NextPlot', 'replace');
                    %%%%%%%%%%%%%%%%%%%
                    
                    set(get(colocAxes, 'Parent'), 'NextPlot', 'replace');
%                     titleString = sprintf('Spearman Coefficient $$\\rho$$ = %.3f\nInflection Point at GP = %.3f', rho, cdfVal(cdfInfPt, 1));
                    titleString = sprintf('Inflection Point at GP = %.3f\nDelta Inflection Point = %.3f (%.3f, +%.3f)', ...
                        cdfInfPt, cdfInfPointPref(1), cdfInfPointPref(2), cdfInfPointPref(3));
                    title(colocAxes, titleString, 'interpreter', 'latex');

                    % Assemble into master figure
                    % Clumsy way to do this, but what the hell.  It works.
                    AssembleFig = figure(15);
                    clf(AssembleFig);
                    set(AssembleFig, 'Position', [100 100 900 850], 'Color', [1 1 1]);
                    set(regAxes, 'Parent', AssembleFig, 'Position', [0.005 .54 .43 .45]); % top left
                    set(phasImgAxes, 'Parent', AssembleFig, 'Position', [.44 .54 .49 .45], 'box', 'off'); % top right
                    set(phasorAx, 'Parent', AssembleFig, 'Position', [0.065 0.06 .36 .45], 'YDir', 'normal'); % bottom left
                    set(colocAxes, 'Parent', AssembleFig, 'Position', [.505 0.0505 .44 .44]); % bottom right
                    set(cumSumAxes, 'Parent', AssembleFig, 'Position', [.505 0.0505 .44 .44]); % bottom right
                    
                    text(10, 30, sprintf('Registered Images\nM - Laurdan\nG - mCherry\nW - Thresholded Area'), 'Color', 'c', 'Parent', regAxes)
                    
                    
                    c = colorbar('Peer', phasImgAxes);
                    ylabel(c, 'GP Value', 'FontSize', 12);
                    set(c, 'YTick', 0:8:64);
                    set(c, 'YTickLabel', num2str(((0:8:64)*(diff(gpImgDisplayRange)/64) - 1)'));
                    set(c, 'FontSize', 10);
                    
                    
                    figsOpen = findobj('Type', 'figure');
                    close(figsOpen(figsOpen ~= AssembleFig));
                    
                    
                    figImg = getframe(AssembleFig);
                    imwrite(figImg.cdata, figFileName);
                    
                    % Output text file of cumulative distribution data
                    
                    fID = fopen(cumDataFileName, 'w');
                    fprintf(fID, '# %s\r\n', lsmFile);
                    fprintf(fID, '# Cumulative distribution of mCherry Intensity wrt GP value\r\n');
                    fprintf(fID, '# Inflection Point at GP Value = %.4f\r\n', cdfInfPt);
                    fprintf(fID, '# Delta Inflection Point = %.4f + %.4f - %.4f\r\n', ...
                        cdfInfPointPref(1), cdfInfPointPref(2), cdfInfPointPref(3));
                    if strcmp(filterType, 'gaussian')
                        fprintf(fID, '# Input Filter = %s\tSigma = %.2f\r\n', filterType, GaussianSigma);
                    elseif strcmp(filterType, 'median')
                        fprintf(fID, '# Input Filter = %s\tNhood = [%.2f %.2f]\r\n', filterType, MedianfilterNhood(1), MedianfilterNhood(2));
                    end
                    fprintf(fID, '# DilateRadius = %.2f\tErodeRadius = %.2f\r\n', mCherryMaskDilate, mCherryMaskErode);
                    fprintf(fID, '# Fit Method = %s\r\n', fitMethod);
                    fprintf(fID, '# Fit Rsquared Threshold = %.2f\r\n', FitRsquaredThreshold);
                    fprintf(fID, '# Lo Wavelength = %.2f\tLd Wavelength = %.2f\r\n', LoWavelength, LdWavelength);
                    fprintf(fID, '# Num Bootstrap Iterations = %.2f\r\n', NBootstrapSamples);
                    fprintf(fID, '# Bootstrap Percentile Range = %.2f to %.2f\r\n', PercentileToPlot(1), PercentileToPlot(2));
                    fprintf(fID, '# # # # # # # # # # # # # # # # # # # # # #\r\n');
                    fprintf(fID, 'GP value\tCum mCherry Int\tMean Bootstrapped Int\tLow Pctile Int\tHigh Pctile Int\r\n');
                    for ln = 1:size(cdfVal, 1)
                        fprintf(fID, '%.4f\t%.4f\t%.4f\t%.4f\t%.4f\r\n', ...
                            cdfVal(ln, :), MeanCDFCurve(ln), PercentileCurves(ln,1), PercentileCurves(ln,2)); % add mean, low Pctile, high Pctile
                    end
                    fclose(fID);
                    
                    
                    % Save mCherry Intensity as a function of GP value in
                    % pixels measured
                    fID = fopen(mCherryvsGPFileName, 'w');
                    fprintf(fID, '# %s\r\n', lsmFile);
                    fprintf(fID, '# mCherry Intensity wrt GP value\r\n');
                    if strcmp(filterType, 'gaussian')
                        fprintf(fID, '# Input Filter = %s\tSigma = %.2f\r\n', filterType, GaussianSigma);
                    elseif strcmp(filterType, 'median')
                        fprintf(fID, '# Input Filter = %s\tNhood = [%.2f %.2f]\r\n', filterType, MedianfilterNhood(1), MedianfilterNhood(2));
                    end
                    fprintf(fID, '# DilateRadius = %.2f\tErodeRadius = %.2f\r\n', mCherryMaskDilate, mCherryMaskErode);
                    fprintf(fID, '# Fit Method = %s\r\n', fitMethod);
                    fprintf(fID, '# Fit Rsquared Threshold = %.2f\r\n', FitRsquaredThreshold);
                    fprintf(fID, '# Lo Wavelength = %.2f\tLd Wavelength = %.2f\r\n', LoWavelength, LdWavelength);
                    fprintf(fID, '# # # # # # # # # # # # # # # # # # # # # #\r\n');
                    fprintf(fID, 'GP value\tmCherry Int\r\n');
                    for ln = 1:size(mCherryInts, 1)
                        fprintf(fID, '%.4f\t%.4f\r\n', ...
                            dataOut(ln,1), mCherryInts(ln)); 
                    end
                    fclose(fID);

                folderPathHere = fileparts(cumDataFileName);
                PoolmCherryDataByTarget(folderPathHere,'GP');
                
                end
                
                end
                
            end
            
            
        end
        

        
    end
end






