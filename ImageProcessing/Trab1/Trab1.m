clear all;
close all;
clc;

Mrgb = imread('Mars.bmp');
[h, w, c] = size(Mrgb);

figure, imshow(uint8(Mrgb));
Mgray = zeros(h,w);
Mteste = zeros(h,w);
Mheq = zeros(h,w);




for i = 1:h
    for j = 1:w
        Mgray(i,j) = Mrgb(i,j,1)*0.299;
    end
end

for i = 1:h
    for j = 1:w
        Mgray(i,j) = Mgray(i,j) + Mrgb(i,j,2)*0.587;
    end
end

for i = 1:h
    for j = 1:w
        Mgray(i,j) = Mgray(i,j) + Mrgb(i,j,3)*0.114;
    end
end

figure, imshow(uint8(Mgray));


% y = 0,299*R + 0,587*G + 0,114*B




% Equalizacão de histograma

MindicesCinza = zeros(256,1);
Prk = zeros(256,1);
Sk = zeros(256,1);
soma = 0;

for k = 1:256
    for i = 1:h
        for j = 1:w
            if Mgray(i,j) == (k - 1)
                MindicesCinza(k) = MindicesCinza(k) + 1;
            end
        end
    end
end


Prk = (MindicesCinza(:,1)/(h*w));


Sk(1) = Prk(1);
for i = 2:256
    Sk(i) = Sk(i-1) + Prk(i); 
end

for i = 1:h
    for j = 1:w
        Mheq(i,j) = round(255*Sk(Mgray(i,j)+1));
    end
end

figure, imshow(uint8(Mheq))
line(Mheq(260, 415),Mheq(815, 1000),'marker','x','color','k',...
   'markersize',10,'linewidth',2,'linestyle','none');


% Calculo da distância
NeighbourPixels = zeros(3,3);
Matual = zeros(2,1);
Menores = zeros(3,4);
Matual(1) = 260;
Matual(2) = 415;
Menores(1) = (((Matual(1) - 815)^2 + (Matual(2) - 1000)^2)^(1/2));

while Matual(1) ~= 815 || Matual(2) ~= 1000
    for i = 1:3
        for j = 1:3
            NeighbourPixels(i,j) = ((((Matual(1) + (i-2)) - 815)^2 + ((Matual(2) + (j-2)) - 1000)^2)^(1/2));
            if NeighbourPixels(i,j) < Menores(1,1)
                Menores(3,:) = Menores(2,:);
                Menores(2,:) = Menores(1,:);
                Menores(1,1) = NeighbourPixels(i,j);
                Menores(1,2) = (Matual(1) + (i-2));
                Menores(1,3) = (Matual(2) + (j-2));
                Menores(1,4) = Mheq((Matual(1) + (i-2)), (Matual(2) + (j-2)));
            elseif NeighbourPixels(i,j) < Menores(2,1)
                Menores(3,:) = Menores(2,:);
                Menores(2,1) = NeighbourPixels(i,j);
                Menores(2,2) = (Matual(1) + (i-2));
                Menores(2,3) = (Matual(2) + (j-2));
                Menores(2,4) = Mheq((Matual(1) + (i-2)), (Matual(2) + (j-2)));
            elseif NeighbourPixels(i,j) < Menores(3,1)
                Menores(3,1) = NeighbourPixels(i,j);
                Menores(3,2) = (Matual(1) + (i-2));
                Menores(3,3) = (Matual(2) + (j-2));
                Menores(3,4) = Mheq((Matual(1) + (i-2)), (Matual(2) + (j-2)));
            end
        end
    end

    for i = 1:3
        if Menores(i,4) > Menores(1,4)
            Menores(1,4) = Menores(i,4);
            Menores(1,2) = Menores(i,2);
            Menores(1,3) = Menores(i,3);

        end
    end

    Matual(1) = Menores(1,2);
    Matual(2) = Menores(1,3);
    Mrgb(Menores(1,2), Menores(1,3), :) = 0;
    Menores = zeros(3,4);
    Menores(1) = (((Matual(1) - 815)^2 + (Matual(2) - 1000)^2)^(1/2));
    
end

figure, imshow(uint8(Mrgb));
        
