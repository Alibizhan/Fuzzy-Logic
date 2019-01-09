clc;clear;clear all;
global  mu_xi X mu_X; 

altsinir_mKare=0; ustsinir_mKare=100; altsinir_konum=0; ustsinir_konum=100;  
evFiyati_altsinir=0; evFiyati_ustsinir=100;

A=altsinir_mKare:5:ustsinir_mKare;
S=altsinir_konum:5:ustsinir_konum;


for i=1:size(A,2)
    for j=1:size(S,2)
%         toplam_alan=0

%numerik girisler

a=A(i); s=S(j);
  
%Numerik girislerin, girsi cikis uyelik fonk ,Bulanik kumelerin tanimlanmasi

%1.uyelik fonksiyonlari ve bulaniklaþtirma
ucgen(altsinir_mKare,0,0,40,ustsinir_mKare,a); az_mKare_xi=mu_xi;
ucgen(altsinir_mKare,30,50,70,ustsinir_mKare,a); orta_mKare_xi=mu_xi; 
ucgen(altsinir_mKare,60,80,100,ustsinir_mKare,a); cok_mKare_xi=mu_xi;


%2. konum deðerlerine ait uyelik fonk girisleri...
ucgen(altsinir_konum,0,0,40,ustsinir_konum, s); kotu_konum_xi=mu_xi; 
ucgen(altsinir_konum,30,50,70,ustsinir_konum, s); orta_konum_xi=mu_xi;  
ucgen(altsinir_konum,60,80,100,ustsinir_konum, s); iyi_konum_xi=mu_xi; 

%cikis uyelik fonk
ucgen2(evFiyati_altsinir,0,0,25,evFiyati_ustsinir);  ucuzEvFiyat_mu=mu_X;
ucgen2(evFiyati_altsinir,20,35,50,evFiyati_ustsinir); ortaEvFiyat_mu=mu_X;
ucgen2(evFiyati_altsinir,40,55,70,evFiyati_ustsinir); yuksekEvFiyat_mu=mu_X;
ucgen2(evFiyati_altsinir,65,83,100,evFiyati_ustsinir); cokYuksekEvFiyat_mu=mu_X;

%Kurallarin tanimlanmasi ve gecerlilik derecelerin hesaplanmasi

mu_kural1=min(az_mKare_xi,kotu_konum_xi);
mu_kural2=min(az_mKare_xi,orta_konum_xi);
mu_kural3=min(az_mKare_xi,iyi_konum_xi);

mu_kural4=min(orta_mKare_xi,kotu_konum_xi);
mu_kural5=min(orta_mKare_xi,orta_konum_xi);
mu_kural6=min(orta_mKare_xi,iyi_konum_xi);

mu_kural7=min(cok_mKare_xi,kotu_konum_xi);
mu_kural8=min(cok_mKare_xi,orta_konum_xi);
mu_kural9=min(cok_mKare_xi,iyi_konum_xi);

mu_sonuc1=mu_kural1*ucuzEvFiyat_mu;
mu_sonuc2=mu_kural2*ucuzEvFiyat_mu;
mu_sonuc3=mu_kural3*ortaEvFiyat_mu;

mu_sonuc4=mu_kural4*ucuzEvFiyat_mu;
mu_sonuc5=mu_kural5*ortaEvFiyat_mu;
mu_sonuc6=mu_kural6*yuksekEvFiyat_mu;

mu_sonuc7=mu_kural7*ortaEvFiyat_mu;
mu_sonuc8=mu_kural8*yuksekEvFiyat_mu;
mu_sonuc9=mu_kural9*cokYuksekEvFiyat_mu;



%birlestirme operatoru olarak max kullanilmistir 1. ÇIKIS
mu_birlestirme=mu_sonuc1+mu_sonuc2+mu_sonuc3+mu_sonuc4+mu_sonuc5+mu_sonuc6+mu_sonuc7+mu_sonuc8+mu_sonuc9;

toplam_alan=sum(mu_birlestirme); 
if toplam_alan == 0
    't';
end
z(i,j)=sum(mu_birlestirme.*X)/toplam_alan;
    end %j
end %i

figure(1);
[a,s]=meshgrid(A,S);

% t=length(a);
% r=length(s);
% u=length(z);
% disp("a'nin uzunlugu  ")
% disp(t);
% disp("s'nin uzunlugu  ")
% disp(r);
% disp("z'nin uzunlugu  ")
% disp(u);

surf(a,s,z')%X ve Y ye göre z'leri çizer
title('Mamdani Surface')

xlabel('mKare__xi');
ylabel('konum__xi');
zlabel('evFiyati__xi');


