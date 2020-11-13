function [newImage rectPosition] = SelectNotch(origImage,varargin)
%SELECTNOTCH Takes in an image and allows the user to select a region. The
%output is a zoomed in picture of that region.
%   Optional argument, previousRegions, is a nx4 array indicating previous
%   rectangles that have been analyzed where a row consists of
%   [xmin,ymin,xdistance,ydistance]. The previous regions will be selected
%   on the image

%****** INPUT PARSING *********************
previousRegions = [];
p = inputParser();
addRequired(p,'origImage',@isnumeric);
checkmat = @(x) isnumeric(x) && (size(x,2) == 4 || size(x,2) == 0);
addOptional(p, 'previousRegions', previousRegions, checkmat);
parse(p,origImage,varargin{:});

previousRegions = p.Results.previousRegions;
%*********************************************


imshow(origImage);
% Display previously selected regions
for i= 1:size(previousRegions,1)
    rectangle('Position',previousRegions(i,:),'EdgeColor','red','LineWidth',1.5)
end

% Select new region
roi = drawrectangle();
rectPosition = roi.Position;
xmin = round(roi.Position(1));
ymin = round(roi.Position(2));
xmax = round(roi.Position(1) + roi.Position(3));
ymax = round(roi.Position(2) + roi.Position(4));
newImage = origImage(ymin:ymax, xmin:xmax, :);
% imshow(newImage)
end
