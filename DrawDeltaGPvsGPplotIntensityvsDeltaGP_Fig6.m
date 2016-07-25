% Delta GP vs intensity using already-calc'd masks
% Adds intensity annotations to Fig6. 
% Run DeltaGPResultsPlot_Fig6.m before this script

GPIColor = [142, 68, 173]/255;
CavColor = [52, 152, 219]/255;

CtrlPMMark = 's';
CtrlWhMark = 's';
KCPMMark = '^';
KCWhMark = '^';

barColor = [0 0 0];

ebarWidth = 0.1;

SpreadAmp = 2;

MarkerSize = 6;

mCherryMaskDilate = 1;

%%%%%%%%%%%%%%%%%%

TFRCtrlFiles = {'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\0.1-TfR-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'; ...
                '\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\0.2-TfR-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'; ...
                '\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\0.3-TfR-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'; ...
                '\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\0.4-TfR-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'; ...
                '\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\0.5-TfR-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'; ...
                '\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\0.6-TfR-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'; ...
                '\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\0.7-TfR-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'; ...
                '\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\0.8-TfR-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'; ...
                '\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\0.9-TfR-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'; ...
                '\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\0.10-TfR-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'; ...
                '\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\0.11-TfR-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'; ...
                '\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\0.12-TfR-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'; ...
                '\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\6.1-TfR-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt'; ...
                '\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\6.2-TfR-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt'; ...
                '\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\6.3-TfR-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt'; ...
                '\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\6.4-TfR-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt'; ...
                '\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\6.5-TfR-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt'; ...
                '\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\6.6-TfR-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt'};

TFR7KCFiles = {'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\2.1-TfR-mCherry-Laurdan-7KC-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'; ...
               '\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\2.2-TfR-mCherry-Laurdan-7KC-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'; ...
               '\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\2.4-TfR-mCherry-Laurdan-7KC-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'; ...
               '\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\2.5-TfR-mCherry-Laurdan-7KC-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'; ...
               '\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\1.1-TfR-mCherry-Laurdan--7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'; ...
               '\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\1.2-TfR-mCherry-Laurdan--7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'; ...
               '\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\1.3-TfR-mCherry-Laurdan--7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'; ...
               '\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\1.4-TfR-mCherry-Laurdan--7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'; ...
               '\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\1.5-TfR-mCherry-Laurdan--7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'; ...
               '\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\1.6-TfR-mCherry-Laurdan--7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'; ...
               '\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\1.7-TfR-mCherry-Laurdan--7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'; ...
               '\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\1.8-TfR-mCherry-Laurdan--7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'; ...
               '\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\1.9-TfR-mCherry-Laurdan--7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'; ...
               '\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\1.10-TfR-mCherry-Laurdan--7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'; ...
               '\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\1.11-TfR-mCherry-Laurdan--7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'; ...
               '\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\1.12-TfR-mCherry-Laurdan--7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'};


Cav1CtrlFiles = {'\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\4.1-Cav-1-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt';...
'\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\4.10-Cav-1-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt';...
'\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\4.2-Cav-1-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt';...
'\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\4.3-Cav-1-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt';...
'\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\4.4-Cav-1-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt';...
'\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\4.5-Cav-1-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt';...
'\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\4.7-Cav-1-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt';...
'\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\4.8-Cav-1-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\0.1-Cav1-mCherry-migration-Laurdan-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\0.10-Cav1-mCherry-migration-Laurdan-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\0.2-Cav1-mCherry-migration-Laurdan-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\0.3-Cav1-mCherry-migration-Laurdan-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\0.4-Cav1-mCherry-migration-Laurdan-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\0.5-Cav1-mCherry-migration-Laurdan-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\0.6-Cav1-mCherry-migration-Laurdan-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\0.7-Cav1-mCherry-migration-Laurdan-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\0.8-Cav1-mCherry-migration-Laurdan-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\0.9-Cav1-mCherry-migration-Laurdan-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'};


Cav17KCFiles = {'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\1.1-Cav1-mCherry-Laurdan-7KC-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\1.2-Cav1-mCherry-Laurdan-7KC-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\1.3-Cav1-mCherry-Laurdan-7KC-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\1.4-Cav1-mCherry-Laurdan-7KC-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\1.5-Cav1-mCherry-Laurdan-7KC-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\6.1-Cav1-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\6.10-Cav1-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\6.2-Cav1-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\6.3-Cav1-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\6.4-Cav1-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\6.6-Cav1-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\6.7-Cav1-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'};

GPICtrlFiles = {'\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\2.1-GPI-AP-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt';...
'\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\2.2-GPI-AP-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt';...
'\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\2.5-GPI-AP-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt';...
'\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\2.6-GPI-AP-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\4.1-GPI-AP-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\4.10-GPI-AP-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\4.11-GPI-AP-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\4.12-GPI-AP-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\4.2-GPI-AP-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\4.4-GPI-AP-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\4.5-GPI-AP-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\4.6-GPI-AP-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\4.8-GPI-AP-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\4.9-GPI-AP-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'};

GPI7KCFiles = {'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\3.1-GPI-mCherry-Laurdan-7KC-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\3.2-GPI-mCherry-Laurdan-7KC-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\3.3-GPI-mCherry-Laurdan-7KC-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\3.5-GPI-mCherry-Laurdan-7KC-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\3.1-GPI-AP-mCherry-Laurdan-7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\3.10-GPI-AP-mCherry-Laurdan-7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\3.11-GPI-AP-mCherry-Laurdan-7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\3.3-GPI-AP-mCherry-Laurdan-7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\3.4-GPI-AP-mCherry-Laurdan-7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\3.5-GPI-AP-mCherry-Laurdan-7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\3.6-GPI-AP-mCherry-Laurdan-7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\3.7-GPI-AP-mCherry-Laurdan-7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\3.8-GPI-AP-mCherry-Laurdan-7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\3.9-GPI-AP-mCherry-Laurdan-7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'};

cutDueToNotMatchingOtherDataSets = {'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\3.2-GPI-AP-mCherry-Laurdan-7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
    '\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\2.3-GPI-AP-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt';...
    '\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\2.4-GPI-AP-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt'};

%%

masterFileList = {GPICtrlFiles, GPI7KCFiles, Cav1CtrlFiles, Cav17KCFiles, TFRCtrlFiles, TFR7KCFiles};

% For each file name given, load up that data file and the corresponding
% _cumDistGPVal.txt file.
% _mCherryVsGPValue gives mean value of GP histogram, number of pixels
% that's pulled from (and therefore SEM).
% _cmDistGPVal gives cumulative GP value, DeltaGP value
% Pool into a single output txt file, also a cell for plotting

% poolData cell same structure as masterFileList, but for each file, matrix
% containing;
% [mean of GP, standard deviation, num pixels;
%  cumulative GP, standard deviation, num pixels from above;
% DeltaGP, 0.05 CI, 99.5 CI];

poolData = cell(length(masterFileList), 1);
poolDataPM = cell(length(masterFileList), 1);
cellIntwhole = cell(length(masterFileList), 1);
cellIntPM = cell(length(masterFileList),1);

for m = 1:length(masterFileList)
    
    for f = 1:length(masterFileList{m})
        
      % fileHere = strcat('Y:\Gaus\[ To Long-term Store ]\Joanna Kwiatek\My documents\imaging- raw data', masterFileList{m}{f});
      fileHere = strcat(pwd, masterFileList{m}{f});
       
       if exist(fileHere, 'file') == 2

           GPmCherry = dlmread(fileHere, '\t', 8, 0);

           poolData{m}{f} = zeros(3,3);
           poolData{m}{f}(1,:) = [mean(GPmCherry(:,1)), std(GPmCherry(:,1)), numel(GPmCherry(:,1))];

           % String formatting for filename and load data for _cumDistGPVal file
           uscore = strfind(fileHere, '_mCherry');
           fcum = strcat(fileHere(1:uscore-1), '_cumDistGPVal.txt');
           fID = fopen(fcum);
           fgetl(fID);
           fgetl(fID);

           InfLine = fgetl(fID);
           InfPoint = str2double(InfLine(strfind(InfLine, '=')+1:end));
           % DeltaGP on fourth line
           DeltaGPLine = fgetl(fID);
           numTok = DeltaGPLine(strfind(DeltaGPLine, ' = ')+3:end);
           textData = textscan(numTok, '%f %s %f %s %f');

           fclose(fID);
           
           % String format for cell intensity measurements
           % \15.10.16 Spectral Phasro Laurdan mCherry\whole cells
           % analysed\16.10.2015\CorrectedMasks-original
           % 15.11.05 masks missing
           % \15.11.20 Spectral Phasor Laurdan mCherry\whole cells
           % analysed\20.11.2015\CorrectedMasks
           dateString = strtok(masterFileList{m}{f}, ' ');
           slashSpots = strfind(masterFileList{m}{f}, '\');
           dataFolder = masterFileList{m}{f}(1:slashSpots(2));
           switch dateString
                case '\15.11.20'
                   imgFolderWhole = strcat(masterFileList{m}{f}(1:slashSpots(3)), '20.11.2015\CorrectedMasks');
                   imgFolderPM = strcat(masterFileList{m}{f}(1:slashSpots(2)), 'PM analysed\20.11.2015\CorrectedMasks');
                   dataFolderPM = strcat(masterFileList{m}{f}(1:slashSpots(2)), 'PM analysed\20.11.2015\GP');
                case '\15.11.05'
                    imgFolderWhole = strcat(masterFileList{m}{f}(1:slashSpots(3)), '5.11.2015\CorrectedMasks');
                    imgFolderPM = strcat(masterFileList{m}{f}(1:slashSpots(2)), 'PM analysed\5.11.2015\CorrectedMasks');
                    dataFolderPM = strcat(masterFileList{m}{f}(1:slashSpots(2)), 'PM analysed\5.11.2015\GP');
                case '\15.10.16'
                    imgFolderWhole = strcat(masterFileList{m}{f}(1:slashSpots(3)), '16.10.2015\CorrectedMasks-original');
                    imgFolderPM = strcat(masterFileList{m}{f}(1:slashSpots(2)), 'PM analysed\16.10.2015\CorrectedMasks');
                    dataFolderPM = strcat(masterFileList{m}{f}(1:slashSpots(2)), 'PM analysed\16.10.2015\GP-spectral');
           end
           [~, fp] = fileparts(masterFileList{m}{f});
           uscoreImg = strfind(fp, '_mCherry');
           imgFile = [fp(1:(uscoreImg-1)) '_MaskImg.tif'];
           
           
           maskDataWhole = imread(fullfile(pwd, imgFolderWhole, imgFile));
           
           maskDataPM = imread(fullfile(pwd, imgFolderPM, imgFile));
           
           % mCherry image for each file is the mean of all channels in
           % given LSM data file.
           dataFile = dir(strcat(pwd, dataFolder, '\', fp(1:20), '*-fingerprint.lsm'));
           dL = bfopen(fullfile(pwd, dataFolder, dataFile(1).name));
           mCherryImg = zeros(size(dL{1}{1}, 1), size(dL{1}{1}, 2));
           for frm = 1:size(dL{1}, 1);
            mCherryImg = mCherryImg + double(dL{1}{frm});
           end
           
           mCherryImg = mCherryImg/size(dL{1}, 1);
           
           % Pull out threshold value for mCherry channel and make mask
           cherryThresh = max(mCherryImg(:)) * graythresh(mCherryImg/max(mCherryImg(:)));
           cherryMask = mCherryImg > cherryThresh;
           cherryMask = bwmorph(cherryMask, 'close');
           cherryMask = imfill(cherryMask, 'holes');
           %     cherryMask = bwmorph(cherryMask, 'open');
           cherryMask = bwmorph(cherryMask, 'dilate', mCherryMaskDilate);
           cherryMask = imfill(cherryMask, 'holes');
           
           bkgdmCherryVal = mean(mCherryImg(~cherryMask));
           
           % Pull out background-corrected mean intensity inside whole cell
           % and PM masks
           cellIntwhole{m}{f} = sum(mCherryImg(ge(maskDataWhole(:) , 1)))/sum(ge(maskDataWhole(:), 1)) ...
               - bkgdmCherryVal; % Average intensity inside mask minus background(outside mask)
           
           cellIntPM{m}{f} = sum(mCherryImg(ge(maskDataPM(:), 1)))/sum(ge(maskDataWhole(:), 1)) ...
               - bkgdmCherryVal; % Average intensity inside mask minus background(outside whole cell mask)
           % Don't want to include any interior of cell as the 'background'
           % here so subtract all mCherryImg outside of whole cell mask
           
           
           % Don't forget PM results!
           [~, fp] = fileparts(masterFileList{m}{f});
           pmFile = fullfile(pwd, dataFolderPM, fp);
           if ~strcmp(fp(end), 't')
               pmFile = strcat(pmFile, '.txt');
           end
           GPmCherryPM = dlmread(pmFile, '\t', 8, 0);          

           % String formatting for filename and load data for _cumDistGPVal file
           uscore = strfind(pmFile, '_mCherry');
           fcum = strcat(pmFile(1:uscore-1), '_cumDistGPVal.txt');
           fID = fopen(fcum);
           fgetl(fID);
           fgetl(fID);

           InfLine = fgetl(fID);
           InfPointPM = str2double(InfLine(strfind(InfLine, '=')+1:end));
           % DeltaGP on fourth line
           DeltaGPLine = fgetl(fID);
           numTok = DeltaGPLine(strfind(DeltaGPLine, ' = ')+3:end);
           textDataPM = textscan(numTok, '%f %s %f %s %f');

           fclose(fID);
                   
           
           poolData{m}{f}(2,:) = [InfPoint, std(GPmCherry(:,1)), numel(GPmCherry(:,1))];
           poolData{m}{f}(3,:) = [textData{1}, textData{3}, textData{5}];
           
           
           poolDataPM{m}{f}(1,:) = [mean(GPmCherryPM(:,1)), std(GPmCherryPM(:,1)), numel(GPmCherryPM(:,1))];
           poolDataPM{m}{f}(2,:) = [InfPointPM, std(GPmCherryPM(:,1)), numel(GPmCherryPM(:,1))];
           poolDataPM{m}{f}(3,:) = [textDataPM{1}, textDataPM{3}, textDataPM{5}];
       
       else
           fprintf(1, 'File %s not found.\n', masterFileList{m}{f});
      
       end
       

    end
   
    
    
end

%%

% DeltaGP vs Intensity plot

clear meanVal meanValPM;
for m = 1:length(masterFileList)
    k = 1;
    for f = 1:length(masterFileList{m})
        
        meanVal{m}(k) = poolData{m}{f}(3,1);
        meanValPM{m}(k) = poolDataPM{m}{f}(3,1);
        errorVal{m}(k, 1:2) = poolData{m}{f}(3, 2:3);
        k = k+1;
        
    end
end

clear intVal;
meanInt = [];
for m = 1:length(masterFileList)
    k = 1;
    for f = 1:length(masterFileList{m})
        
        intValWhole{m} = cell2mat(cellIntwhole{m});
        intValPM{m} = cell2mat(cellIntPM{m});
        
   
        k = k+1;
        
        
    end
    
    meanInt = [meanInt; [mean(intValWhole{m}), mean(intValPM{m})]];
    
end

% 
% wholeFig = figure(1);
% clf(wholeFig);
% ax1 = axes('parent', wholeFig);
% % 
% samp = 1;
% plot(ax1, intValWhole{samp}, meanVal{samp}, 'color', GPIColor, 'marker', CtrlWhMark, 'linestyle', 'none');
% hold on
% er1 = errorbarxy(mean(intValWhole{samp}(meanVal{samp} > 0)),  mean(meanVal{samp}(meanVal{samp} > 0)), ...
%     std(intValWhole{samp}(meanVal{samp} > 0))/sqrt(sum(meanVal{samp} > 0)),  std(meanVal{samp}(meanVal{samp} > 0))/sqrt(sum(meanVal{samp} > 0)));
% er2 = errorbarxy(mean(intValWhole{samp}(meanVal{samp} < 0)),  mean(meanVal{samp}(meanVal{samp} < 0)), ...
%     std(intValWhole{samp}(meanVal{samp} < 0))/sqrt(sum(meanVal{samp} < 0)),  std(meanVal{samp}(meanVal{samp} < 0))/sqrt(sum(meanVal{samp} < 0)));
% hold off
% set(er1.hMain, 'color', GPIColor);
% set(er1.hErrorbar, 'color', GPIColor, 'linewidth', 2);
% set(er2.hMain, 'color', GPIColor);
% set(er2.hErrorbar, 'color', GPIColor, 'linewidth', 2);
% 
% samp = 3;
% plot(ax1, intValPM{samp}, meanVal{samp}, 'color', GPIColor, 'marker', CtrlWhMark, 'linestyle', 'none');
% hold on
% er1 = errorbarxy(mean(intValPM{samp}(meanVal{samp} > 0)),  mean(meanVal{samp}(meanVal{samp} > 0)), ...
%     std(intValPM{samp}(meanVal{samp} > 0))/sqrt(sum(meanVal{samp} > 0)),  std(meanVal{samp}(meanVal{samp} > 0))/sqrt(sum(meanVal{samp} > 0)));
% er2 = errorbarxy(mean(intValPM{samp}(meanVal{samp} < 0)),  mean(meanVal{samp}(meanVal{samp} < 0)), ...
%     std(intValPM{samp}(meanVal{samp} < 0))/sqrt(sum(meanVal{samp} < 0)),  std(meanVal{samp}(meanVal{samp} < 0))/sqrt(sum(meanVal{samp} < 0)));
% hold off
% set(er1.hMain, 'color', GPIColor);
% set(er1.hErrorbar, 'color', GPIColor, 'linewidth', 2);
% set(er2.hMain, 'color', GPIColor);
% set(er2.hErrorbar, 'color', GPIColor, 'linewidth', 2);
% 
% samp = 5;
% plot(ax1, intValPM{samp}, meanVal{samp}, 'color', GPIColor, 'marker', CtrlWhMark, 'linestyle', 'none');
% hold on
% er1 = errorbarxy(mean(intValPM{samp}(meanVal{samp} > 0)),  mean(meanVal{samp}(meanVal{samp} > 0)), ...
%     std(intValPM{samp}(meanVal{samp} > 0))/sqrt(sum(meanVal{samp} > 0)),  std(meanVal{samp}(meanVal{samp} > 0))/sqrt(sum(meanVal{samp} > 0)));
% er2 = errorbarxy(mean(intValPM{samp}(meanVal{samp} < 0)),  mean(meanVal{samp}(meanVal{samp} < 0)), ...
%     std(intValPM{samp}(meanVal{samp} < 0))/sqrt(sum(meanVal{samp} < 0)),  std(meanVal{samp}(meanVal{samp} < 0))/sqrt(sum(meanVal{samp} < 0)));
% hold off
% set(er1.hMain, 'color', GPIColor);
% set(er1.hErrorbar, 'color', GPIColor, 'linewidth', 2);
% set(er2.hMain, 'color', GPIColor);
% set(er2.hErrorbar, 'color', GPIColor, 'linewidth', 2);
% 
% %% Need a plot showing split up data.  Best way to do this unclear.
% 
% GPthresh = zeros(length(intValPM), 2);
% ThreshInd = zeros(length(intValPM), 2);
% PVal = zeros(length(intValPM), 2);
% 
% for k = 1:length(intValPM)
%     
%     [vals, I] = sort(meanVal{k});
%     intSort = intValPM{k}(I);
%     
%     pv = zeros(length(vals), 1);
%     
%     for m = 1:length(vals)
%         
%         [~, pv(m)] = ttest2(intValPM{k}(ge(meanVal{k}, vals(m) + eps)), intValPM{k}(meanVal{k} < vals(m)));
%         
%     end
%     
%     PVal(k, 2) = min(pv);
%     ThreshInd(k, 2) = find(pv == min(pv));
%     GPthresh(k, 2) = meanVal{k}(ThreshInd(k, 2));
%     
%     pv = zeros(length(vals), 1);
%     
%     for m = 1:length(vals)
%         
%         [~, pv(m)] = ttest2(intValWhole{k}(ge(meanVal{k}, vals(m) - eps)), intValWhole{k}(meanVal{k} < vals(m)));
%         
%     end
%     
%     PVal(k, 1) = min(pv);
%     ThreshInd(k, 1) = find(pv == min(pv));
%     GPthresh(k, 1) = meanVal{k}(ThreshInd(k, 1));
%     
% end
% 
% %% Add the two-pop values to the summary figure.  Run DeltaGPResultsPlot *before* running this part
% 
% fig4 = figure(4);
% ax = findobj('parent', fig4, 'type', 'axes');
% ax = ax(2);
% set(ax, 'NextPlot', 'add');
% 
% for k = 1:size(PVal, 1)
%     
%     vals = sort(meanVal{k});
%     
%     if PVal(k,1) < 0.05
%         % Draw a line to divide into two populations
%         plot(ax, [k-.5 k+0.5], repmat(mean(vals(ThreshInd(k,1)+[0 -1])), 1, 2), ':', 'color', 'r', 'linewidth', 2);
%     end
%     
% end
% 
% fig3 = figure(3);
% ax2 = findobj('parent', fig3, 'type', 'axes');
% ax2 = ax2(2);
% set(ax2, 'NextPlot', 'add');
% 
% for k = 1:size(PVal, 1)
%     
%     vals = sort(meanVal{k});
%     
%     if PVal(k,2) < 0.05
%         % Draw a line to divide into two populations
%         plot(ax2, [k-.5 k+0.5], repmat(mean(vals(ThreshInd(k,2)+[0 -1])), 1, 2), ':', 'color', 'r', 'linewidth', 2);
%         disp(k)
%     end
%     
% end
      
%% Try splitting up Delta GP with Otsu's method.  Then see how that predicts original image intenstiy.  
% Connects DeltaGP observed back to a underlying value.
PVal = zeros(length(intValWhole), 2);
AbsThresh = zeros(length(intValWhole), 2);
subPopMeans = zeros(length(intValWhole), 3);
MeanEitherSide = zeros(length(intValWhole), 2);
SEMEitherSide = zeros(length(intValWhole), 2);

for k = 1:length(intValWhole)
    threshVal = graythresh((meanVal{k} - min(meanVal{k}))/(max(meanVal{k}) - min(meanVal{k})));
    AbsThresh(k,1) = threshVal*(max(meanVal{k}) - min(meanVal{k})) + min(meanVal{k});
    [~, PVal(k,1)] = ttest2(intValWhole{k}(meanVal{k} > AbsThresh(k,1)), intValWhole{k}(meanVal{k} < AbsThresh(k,1)));
    subPopMeans(k,:) = [mean(intValWhole{k}(meanVal{k} > AbsThresh(k,1))), mean(intValWhole{k}(meanVal{k} < AbsThresh(k,1))), mean(intValWhole{k})];
    MeanEitherSide(k, :) = [sum(meanVal{k}(meanVal{k} > AbsThresh(k,1)).*(1./errorVal{k}((meanVal{k} > AbsThresh(k,1)))))/(sum((1./errorVal{k}((meanVal{k} > AbsThresh(k,1)))))), ...
        sum(meanVal{k}(meanVal{k} < AbsThresh(k,1)).*(1./errorVal{k}((meanVal{k} < AbsThresh(k,1)))))/(sum((1./errorVal{k}((meanVal{k} < AbsThresh(k,1))))))];
    SEMEitherSide(k, :) = [std(meanVal{k}(meanVal{k} > AbsThresh(k,1)))/(sqrt(sum(meanVal{k} > AbsThresh(k,1)))),...
        std(meanVal{k}(meanVal{k} < AbsThresh(k,1)))/(sqrt(sum(meanVal{k} < AbsThresh(k,1))))];

    threshVal = graythresh((meanValPM{k} - min(meanValPM{k}))/(max(meanValPM{k}) - min(meanValPM{k})));
    AbsThresh(k,2) = threshVal*(max(meanValPM{k}) - min(meanValPM{k})) + min(meanValPM{k});
    [~, PVal(k,2)] = ttest2(meanValPM{k}(intValPM{k} > AbsThresh(k,2)), meanValPM{k}(intValPM{k} < AbsThresh(k,2)));
end

%% Add the threshold values.  Run DeltaGPResultsPlot_Fig6 *before* running this part

fig4 = figure(4);
ax = findobj('parent', fig4, 'type', 'axes');
ax = ax(2);
set(ax, 'NextPlot', 'add');

clr = rgb(231, 40, 80);

for k = 1:size(PVal, 1)

    
    if PVal(k,1) < 0.05
        % Draw a line to divide into two populations
        plot(ax, [k-.5 k+0.5], repmat(AbsThresh(k,1), 1, 2), ':', 'color', clr, 'linewidth', 2);
        
        % Add in mean + SEM for both high-intensity and low-intensity pools
        upDown = 'none';
        downUp = clr; % Fill the lower one by default
        if subPopMeans(k,1) > subPopMeans(k,2) % If the upper one is brighter, fill the upper one.
            upDown = clr;
            downUp = 'none';
        end
        
        % FILLED IS BRIGHTER!
        
%         plot(ax2, [k-.15 k+.15]', [MeanEitherSide(k,1) MeanEitherSide(k,1)]', 'color', rgb(44, 62, 80)...
%             , 'MarkerSize', 10, 'linewidth', 1);
        plot(ax2, k, MeanEitherSide(k,1), 'color', clr...
            , 'MarkerSize', 8, 'linewidth', 1, 'MarkerFaceColor', upDown, 'Marker', 's');
        hands = eBarControl(ax2, k, MeanEitherSide(k,1), SEMEitherSide(k,1), -SEMEitherSide(k,1), .15);
        set(hands, 'color', clr, 'linewidth', 1);
        
        plot(ax2, k, MeanEitherSide(k,2), 'color', clr...
            , 'MarkerSize', 8, 'linewidth', 1, 'MarkerFaceColor', downUp, 'Marker', 's');
        hands = eBarControl(ax2, k, MeanEitherSide(k,2), SEMEitherSide(k,2), -SEMEitherSide(k,2), .15);
        set(hands, 'color', clr, 'linewidth', 1);
    end
    
end

% Add values for second one to compare intensities with the same threshold
k = 2;


highPop = meanVal{k}(intValWhole{k} > abs(subPopMeans(k-1,1)-subPopMeans(k-1,2))/2 + min(subPopMeans(k-1,:), [], 2));
lowPop = meanVal{k}(intValWhole{k} < abs(subPopMeans(k-1,1)-subPopMeans(k-1,2))/2 + min(subPopMeans(k-1,:), [], 2));

highError = errorVal{k}(intValWhole{k} > abs(subPopMeans(k-1,1)-subPopMeans(k-1,2))/2 + min(subPopMeans(k-1,:), [], 2));
lowError = errorVal{k}(intValWhole{k} < abs(subPopMeans(k-1,1)-subPopMeans(k-1,2))/2 + min(subPopMeans(k-1,:), [], 2));

% Here brighter one is the lowPop
upDown = clr;
downUp = 'none'; % Fill the lower one by default

plot(ax2, k, sum(highPop.*(1./highError))/(sum(1./highError)), 'color', clr...
    , 'MarkerSize', 8, 'linewidth', 1, 'MarkerFaceColor', upDown, 'Marker', '^');
hands = eBarControl(ax2, k, sum(highPop.*(1./highError))/(sum(1./highError)), ...
    std(highPop)/sqrt(numel(highPop)), -std(highPop)/sqrt(numel(highPop)), .15);
set(hands, 'color', clr, 'linewidth', 1);

plot(ax2, k, sum(lowPop.*(1./lowError))/(sum(1./lowError)), 'color', clr...
    , 'MarkerSize', 8, 'linewidth', 1, 'MarkerFaceColor', downUp, 'Marker', '^');
hands = eBarControl(ax2, k, sum(lowPop.*(1./lowError))/(sum(1./lowError)), ...
    std(lowPop)/sqrt(numel(lowPop)), -std(lowPop)/sqrt(numel(lowPop)), .15);
set(hands, 'color', clr, 'linewidth', 1);

% Add values for last one to compare intensities with the same threshold
k = 6;
% Here brighter one is the lowPop
upDown = clr;
downUp = 'none'; % Fill the lower one by default

highPop = meanVal{k}(intValWhole{k} > abs(subPopMeans(k-1,1)-subPopMeans(k-1,2))/2 + min(subPopMeans(k-1,:), [], 2));
lowPop = meanVal{k}(intValWhole{k} < abs(subPopMeans(k-1,1)-subPopMeans(k-1,2))/2 + min(subPopMeans(k-1,:), [], 2));

plot(ax2, k, mean(highPop), 'color', clr...
    , 'MarkerSize', 8, 'linewidth', 1, 'MarkerFaceColor', upDown, 'Marker', '^');
hands = eBarControl(ax2, k, mean(highPop), ...
    std(highPop)/sqrt(numel(highPop)), -std(highPop)/sqrt(numel(highPop)), .15);
set(hands, 'color', clr, 'linewidth', 1);

plot(ax2, k, mean(lowPop), 'color', clr...
    , 'MarkerSize', 8, 'linewidth', 1, 'MarkerFaceColor', downUp, 'Marker', '^');
hands = eBarControl(ax2, k, mean(lowPop), ...
    std(lowPop)/sqrt(numel(lowPop)), -std(lowPop)/sqrt(numel(lowPop)), .15);
set(hands, 'color', clr, 'linewidth', 1);


fig3 = figure(3);
ax2 = findobj('parent', fig3, 'type', 'axes');
ax2 = ax2(2);
set(ax2, 'NextPlot', 'add');

for k = 1:size(PVal, 1)

    
    if PVal(k,2) < 0.05
        % Draw a line to divide into two populations
        plot(ax2, [k-.5 k+0.5], repmat(AbsThresh(k,2), 1, 2), ':', 'color', [231, 76, 60]/255, 'linewidth', 2);
        disp(k)
    end
    
end





% These two cases are where identifying sub-populations with Delta GP
% *also* identified sub-populations in image intensity.  This could mean
% something about either expression levels or necessary intensities to
% differentiate signal.  But I don't think it's the required intensity
% since it's seen in TfR, which is already higher than GPI, and not in
% Cav1, which is lower than TfR.  So there's something to the expression
% level, most likely. 



% %% Print them!
% 
% set(f2, 'paperpositionmode', 'auto');
% print(f2, 'D:\Dropbox\Proposals\DeltaGP\Figures\ComparisonPointsDelGP.png', '-dpng', '-r300');
% print(f2, 'D:\Dropbox\Proposals\DeltaGP\Figures\ComparisonPointsDelGP.eps', '-depsc', '-r300');
% 
% set(f3, 'paperpositionmode', 'auto');
% print(f3, 'D:\Dropbox\Proposals\DeltaGP\Figures\ComparisonPointsAvgGP.png', '-dpng', '-r300');
% print(f3, 'D:\Dropbox\Proposals\DeltaGP\Figures\ComparisonPointsAvgGP.eps', '-depsc', '-r300');
% 
% set(f4, 'paperpositionmode', 'auto');
% print(f4, 'D:\Dropbox\Proposals\DeltaGP\Figures\ComparisonPointsCumGP.png', '-dpng', '-r300');
% print(f4, 'D:\Dropbox\Proposals\DeltaGP\Figures\ComparisonPointsCumGP.eps', '-depsc', '-r300');