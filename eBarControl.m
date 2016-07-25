function lineHandles = eBarControl(ax, xvals, yctr, yplus, yminus, width)

set(ax, 'nextplot', 'add');
h1 = plot(ax, [xvals' xvals']', [yctr+yplus yctr+yminus]');
h2 = plot(ax, [xvals'-width xvals'+width]', [yctr+yplus yctr+yplus]');
h3 = plot(ax, [xvals'-width xvals'+width]', [yctr+yminus yctr+yminus]');

lineHandles = [h1 h2 h3];