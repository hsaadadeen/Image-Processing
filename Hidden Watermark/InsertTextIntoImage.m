%% Prepare the image
PrepareImage;

%% Determine using Random number gerenrator or not
%if(0) not use
%else Using the Random number with this seed
UsingSeed = 5;

%% The string need to be inserted
string = 'Done El7amdo llah';
fprintf('The string you want to insert is ''%s'' \n\n',string);



%% Insert the text into the image
%% Validiate the condition of inserting the string
%The whole image in one column
img = OriginalImage(:);
if((length(string)+1)*8 <= length(img))
    fprintf('The string length is fine!\n');
else
    error('The string length is Too Long\n Thanks for using our program!\n ');  
end

%% Generate the index of using Key
if(UsingSeed ~= 0)
    rand('seed',UsingSeed);
    IndexMap = randperm(length(img));
    fprintf('You will use a key to Encrypt the string in the image do not miss it !!\n ');
end
%% Set the least significant bit to 0
% using 254 which in binary 11111110 anded with the orginal image
img_Zero_InTheLeast = bitand(img,ones(length(img),1,'uint8')*254);

%% Insert the string
for i=1:length(string)
    for k=1:8
        bit = bitget(uint8(string(i)),k);
        if(bit == 1)
            if(UsingSeed ~= 0)
                index = IndexMap((i-1)*8 +k);
            else
                index = (i-1)*8+k;
            end
            img_Zero_InTheLeast(index) = bitset(img_Zero_InTheLeast(index),1);
        end
    end
end

%% Insert the Cap Char
for k=1:8 
    if(UsingSeed ~= 0)
        index = IndexMap(length(string)*8+k);
    else
        index = (length(string))*8+k;
    end
    img_Zero_InTheLeast(index) = bitset(img_Zero_InTheLeast(index),1);
end

%% Reconstruct the image
[x,y,z]=size(OriginalImage);                             
Image_With_Watermark=reshape(img_Zero_InTheLeast,x,y,z);

figure,imshow(Image_With_Watermark),impixelinfo,title('Image With Watermark');
imwrite(Image_With_Watermark,'WaterMarkedImage.png','png');