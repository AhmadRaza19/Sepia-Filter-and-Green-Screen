% Project 7 - Sepia Filter + Green Screen
% Ahmad Raza
% CS 109, Koehler, Fall 2020

%%Part 1

%This function applies a sepia filter to a photo
%INPUT
    %imageFile - a character array filename of an image
%OUTPUT
    %imArraySepia - a 3D image array with the sepia filter applied
    
%Testing the code Part 1
[newIm] = sepiaFilter('city.jpg');
% [newIm] = sepiaFilter('bigben.jpg');
% [newIm] = sepiaFilter('treeBackground.jpg');


%Testing the code Part 2
%Testing the code
% test green screen
front = 'tiger.jpg';
back = 'colorBackground.jpg';
figure
[im] = greenScreen(front, back, 2, 1.5);

% test red screen
% front = 'catred.jpg';
% back = 'purpleBackground.jpg';
% figure
% [im] = greenScreen(front, back, 1, 2.5);

% test blue screen
% front = 'dino.jpg';
% back = 'bigben.jpg';
% figure
% [im] = greenScreen(front, back, 3, 1.3);

function [imArraySepia] = sepiaFilter(imageFile)
    img = imread(imageFile);
    imArraySepia = img;
    sz = size(img);
    for i = 1:sz(1) %For loop for all pixels
        for j = 1:sz(2)
            imArraySepia(i,j,1) = 0.393 * img(i,j,1) + 0.769 * img(i,j,2) + 0.189 * img(i,j,3); %new red values
            imArraySepia(i,j,2) = 0.349 * img(i,j,1) + 0.686 * img(i,j,2) + 0.168 * img(i,j,3); %new green values
            imArraySepia(i,j,3) = 0.272 * img(i,j,1) + 0.534 * img(i,j,2) + 0.131 * img(i,j,3); %new blue values
        end
    end
    %Subplots for original and filtered
    subplot (1,2,1);
    imshow(img);
    title("original");
    subplot (1,2,2);
    imshow(imArraySepia);
    title("filtered");
end

%%Part 2

%This function overlays one image over another using a filtering algorithm
%with a green screen.

%INPUTS
    %frontFile - string filename of the front image (with a red, green,or
    %blue screen)
    %backFile - string filename of the back image
    %ch - 1 (red screen)
    %     2 (green screen)
    %     3 (blue screen)
    %cd - channel difference
    
%OUTPUTS
    %newImage - data array for combined image
    

function [newImage] = greenScreen(frontFile, backFile, ch, cd )
   A = imread(frontFile);
   B = imread(backFile);
   sz1 = size(A);
   sz2 = size(B);
   newImage = A;
   if sz1 == sz2 %Conditional Statement for same size
       for i = 1:sz1(1) %For loop for all pixels
           for j = 1:sz1(2)
               red  = A(i,j,1);
               green = A(i,j,2);
               blue = A(i,j,3);
               if ch == 1 %Conditional Statement for Red
                   if (red > cd * blue) && (red > cd * green) %Condidtional Statement for if larger than cd times
                       newImage(i,j,:) = B(i,j,:);
                   else
                       newImage(i,j,:) = A(i,j,:);
                   end
               elseif ch == 2 %Conditional Statement for Green
                   if (green > cd * red) && (green > cd * blue)
                       newImage(i,j,:) = B(i,j,:);
                   else
                       newImage(i,j,:) = A(i,j,:);
                   end
               elseif ch == 3 %Conditional Statement for Blue
                   if (blue > cd * red) && (blue > cd * green)
                       newImage(i,j,:) = B(i,j,:);
                   else
                       newImage(i,j,:) = A(i,j,:);
                   end
               end
            
           end
       end
   else %Returns empty array if false
       newImage = [];
   end
   %Subplots for before and after green screening
   subplot(2,2,1);
   imshow(A);
   title("before");
   subplot(2,2,3);
   imshow(B);
   subplot(2,2,2);
   imshow(newImage);
   title("after");
end
