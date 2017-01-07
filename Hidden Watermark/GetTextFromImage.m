%% Determine using Random number gerenrator or not
%if(0) not use
%else Using the Random number with this seed
UsingSeed = 5;

%% Read and show the image
PrepareImage;
WatermarkedImage = OriginalImage;
figure,imshow(WatermarkedImage),impixelinfo,title('Watermarked Image');

%% Validiate the condition of inserting the string
%The whole image in one column
img = WatermarkedImage(:);
%The string
String = '';
%Check if using a key
if UsingSeed ~= 0
    rand('seed',UsingSeed);
    IndexMap = randperm(length(img));
end

%% Analyze the Image
i = 1;
flag = 0;

while (i <= length(img) && (flag == 0))
    bitchar=uint8(0);                           %Clear bitchar
    for j=1:8
        if UsingSeed ~= 0
            index = IndexMap((i-1) + j);
        else
            index=(i-1) + j;
        end
        
        b=bitget(img(index),1);                 %Get the least segnificant bit
        if(b==1)
            bitchar=bitset(bitchar,j);
        end
    end
    
    if(bitchar==255)                            %Check whether the character read is the cap
        flag = 1;
    else                                        %else update the string
        b_index=(i-1)/8 +1;
        String(b_index)=char(bitchar);
        i=i+8;
    end
end

%% Print the output
fprintf('\n %s \n',String);