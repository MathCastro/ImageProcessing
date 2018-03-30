clear all;
close all;
clc;

Mblack = imread('spots.tif');
[h, w] = size(Mblack);

figure, imshow(uint8(Mblack));

Malocada = zeros(h+4,w+4);

for i = 1:h
    for j = 1:w
        Malocada(i+2,j+2) = Mblack(i,j);
    end
end

for i = 1:2
    for j = 1:(w+4)
        Malocada(i,j) = 255;
    end
end

for i = (h+2):(h+4)
    for j = 1:(w+4)
        Malocada(i,j) = 255;
    end
end

for i = 1:(h+4)
    for j = 1:2
        Malocada(i,j) = 255;
    end
end

for i = 1:(h+4)
    for j = (w+2):(w+4)
        Malocada(i,j) = 255;
    end
end

[h2, w2] = size(Malocada);
 
for i = 1:h2
    for j = 1:w2
        if Malocada(i,j) > 128
            Malocada(i,j) = 1;
        else
            Malocada(i,j) = 0;
        end
    end
end


figure, imshow((Malocada));
        