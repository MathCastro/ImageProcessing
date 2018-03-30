clear all;
close all;
clc;

Mblack = imread('spots.tif');
[h, w] = size(Mblack);


Malocada = zeros(h+4,w+4);
Mindices = zeros(h+4,w+4);
Equivalente = zeros(2,1);
[h2, w2] = size(Malocada);
Qpretos = 0;
n = 0;

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

 
for i = 1:h2
    for j = 1:w2
        if Malocada(i,j) > 128
            Malocada(i,j) = 1;
        else
            Malocada(i,j) = 0;
        end
    end
end

for i = 2:h2
    for j = 2:w2
        if Malocada(i,j) == 0
            if Malocada(i-1,j) == 0 && Malocada(i, j-1) == 0
                if Mindices(i-1,j) ~= Mindices(i, j-1)
                    n = n + 1;
                    Mcorrespondencia(n,:) = [Mindices(i-1,j),Mindices(i, j-1)];
                    Mindices(i,j) = Mindices(i,j-1);
                else
                    Mindices(i,j) = Mindices(i,j-1);
                end
            elseif Malocada(i-1,j) == 0
                Mindices(i,j) = Mindices(i-1,j);
            elseif Malocada(i, j-1) == 0
                Mindices(i,j) = Mindices(i,j-1);
            else
                Qpretos = Qpretos + 1;
                Mindices(i,j) = Qpretos;
            end
        end
    end
end

for k = 1:size(Mcorrespondencia)
    Equivalente(1) = Mcorrespondencia(k,1);
    Equivalente(2) = Mcorrespondencia(k,2);
    
    for i = 2:h2
        for j = 2:w2
            if Mindices(i,j) == Equivalente(1)
                Mindices(i,j) = Equivalente(2);
            end
        end
    end
end

Mpretos = zeros (1,1);
Tamanho = 1;
flag = 0;
for i = 2:h2
    for j = 2:w2
        if Mindices(i,j) ~= 0
            for k = 1:Tamanho
                if Mindices (i,j) == Mpretos(k)
                    flag = 1;
                end
            end
            if flag == 0
                Tamanho = Tamanho + 1;
                Mpretos(Tamanho) = Mindices(i,j);
            end
            flag = 0;
        end 
    end
end    

figure, imshow((Malocada));





% Conta quantos com buraco

Mindices = zeros(h+4,w+4);
Equivalente2 = zeros(2,1);
Qpretos = 0;
n = 0;

for i = 1:h
    for j = 1:w
        if Mblack(i,j) == 1
            Malocada(i+2,j+2) = 0;
        else
            Malocada(i+2,j+2) = 1;
        end
    end
end


for i = 2:h2
    for j = 2:w2
        if Malocada(i,j) == 0
            if Malocada(i-1,j) == 0 && Malocada(i, j-1) == 0
                if Mindices(i-1,j) ~= Mindices(i, j-1)
                    n = n + 1;
                    Mcorrespondencia2(n,:) = [Mindices(i-1,j),Mindices(i, j-1)];
                    Mindices(i,j) = Mindices(i,j-1);
                else
                    Mindices(i,j) = Mindices(i,j-1);
                end
            elseif Malocada(i-1,j) == 0
                Mindices(i,j) = Mindices(i-1,j);
            elseif Malocada(i, j-1) == 0
                Mindices(i,j) = Mindices(i,j-1);
            else
                Qpretos = Qpretos + 1;
                Mindices(i,j) = Qpretos;
            end
        end
    end
end

for k = 1:size(Mcorrespondencia2)
    Equivalente2(1) = Mcorrespondencia2(k,1);
    Equivalente2(2) = Mcorrespondencia2(k,2);
    
    for i = 2:h2
        for j = 2:w2
            if Mindices(i,j) == Equivalente2(1)
                Mindices(i,j) = Equivalente2(2);
            end
        end
    end
end

Mpretos2 = zeros (1,1);
Tamanho2 = 1;
flag = 0;
for i = 2:h2
    for j = 2:w2
        if Mindices(i,j) ~= 0
            for k = 1:Tamanho2
                if Mindices (i,j) == Mpretos2(k)
                    flag = 1;
                end
            end
            if flag == 0
                Tamanho2 = Tamanho2 + 1;
                Mpretos2(Tamanho2) = Mindices(i,j);
            end
            flag = 0;
        end 
    end
end    


figure, imshow((Malocada));
figure, imshow(uint8(Mindices));
        