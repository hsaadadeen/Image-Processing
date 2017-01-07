%% This script used for prepare the image before using


%% Read and show the image
[filename,pathname]=uigetfile('*.*','select the image'); 
file = sprintf('%s\\%s',pathname,filename);
OriginalImage = imread(file);
figure,imshow(OriginalImage),impixelinfo,title('Original Image');

%Number of cols and rows
RowsNumber = length(OriginalImage(:,1,1));
ColsNumber = length(OriginalImage(1,:,1));
