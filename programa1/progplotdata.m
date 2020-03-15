%
clear all
addpath(genpath('mfiles'))

IMAGEFILE="0069_Nir_8b_GeoRef.tiff";
IMAGEPATH="images/images1";

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

DATA=load([ IMAGEFILE '.datafile.dat']);

N=length(DATA.DATACONF);
DW=zeros(N,1);
DATACONF=DATA.DATACONF;

for II=1:N
    DW(II)=norm(DATACONF(II).Pp);
endfor

MEAN=mean(DW)
STD=std(DW)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
LL=round(log2(N))*2;
[NN, XX]=hist(DW,LL);
bar(XX,NN);
xlabel('Pixels');
ylabel('Probability');
print(gcf,[ IMAGEFILE '.hist.eps'],'-depsc');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FILENAME=fullfile(IMAGEPATH,IMAGEFILE);
IMG = double(imread (FILENAME));

figure(1);
imagesc(IMG);
colormap(gray);
daspect([1 1 1]);
refresh(figure(1));
hold on
for II=1:N
    fprintf(stdout,"Dat %3d of %3d\r",II,N);
    Po=DATACONF(II).Po;
    Pp=DATACONF(II).Pp;
    Pl=DATACONF(II).Pl;
    D=DATACONF(II).D;
    NORM=norm(Pp);
    if( (NORM>(MEAN-STD))&&(NORM<(MEAN+STD)) )
    for JJ=-1:1
        P0=Po+[D/2 D/2]+JJ*Pp;
        quiver(P0(2),P0(1),Pl(2),Pl(1),'r','LineWidth',1);
    endfor
    endif
endfor
fprintf(stdout,"\n");
hold off
print(gcf,[ IMAGEFILE '.quiver.eps'],'-depsc');
