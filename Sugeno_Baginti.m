clc;
clear;
clear all;

global mu_xi;
altsinir=0; ustsinir_metreKare=100;
ustsinir_mevki=100; ustsinir_fiyat=100;

X = altsinir:5:ustsinir_metreKare;    Y = altsinir:5:ustsinir_mevki;
a1 = 0.1;         b1 = 0.1;          c1 = 0.24;
a2 = 0.34;        b2 = 0.39;         c2 = 0.59;
a3 = 0.41;        b3 = 0.47;         c3 = 0.63;
a4= .51;          b4= .55;           c4 = 1;
for i=1:size(X,2)
    for j=1:size(Y,2)
    toplam_agirlik = 0;
    
x = X(i);   y = Y(j);


%Bulanik Kumelerin Olusturulmasi
    %metreKare
ucgen(altsinir,0,20,40,ustsinir_metreKare,x);          az_metreKare = mu_xi;
ucgen(altsinir,30,50,70,ustsinir_metreKare,x);         orta_metreKare = mu_xi;
ucgen(altsinir,65,83,100,ustsinir_metreKare,x);        cok_metreKare = mu_xi;
    %mevki
ucgen(altsinir,0,20,40,ustsinir_mevki,y);             kotu_mevki = mu_xi;
ucgen(altsinir,30,50,70,ustsinir_metreKare,y);        orta_mevki = mu_xi;
ucgen(altsinir,65,83,100,ustsinir_metreKare,y);       iyi_mevki = mu_xi;
    %cikis
z1 = a1*x + b1*y + c1;
z2 = a2*x + b2*y + c2;
z3 = a3*x + b3*y + c3;
z4 = a4*x + b4*y + c4;

    %Kurallar
w1 = min(az_metreKare,kotu_mevki);
w2 = min(az_metreKare,orta_mevki);
w3 = min(az_metreKare,iyi_mevki);

w4 = min(orta_metreKare,kotu_mevki);
w5 = min(orta_metreKare,orta_mevki);
w6 = min(orta_metreKare,iyi_mevki);

w7 = min(cok_metreKare,kotu_mevki);
w8 = min(cok_metreKare,orta_mevki);
w9 = min(cok_metreKare,iyi_mevki);

SAT = w1*z1 + w2*z1 + w3*z2 + w4*z2 + w5*z2 + w6*z3 + w7*z2 + w8*z3 + w9*z4;

toplam_agirlik = w1 + w2 + w3 + w4 + w5 + w6 + w7 + w8 + w9;
if toplam_agirlik == 0
    
end
z(i,j) = SAT/toplam_agirlik;

    end
end

surf(X,Y,z);
title('Sugeno Surface')

xlabel('metreKare__xi');
ylabel('mevki__xi');
zlabel('evFiyati__xi');
