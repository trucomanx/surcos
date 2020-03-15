%
clear all
addpath(genpath('mfiles'))
pkg load image

IMAGEFILE="0069_Nir_8b_GeoRef.tiff";
IMAGEPATH="images/images1";
L=200;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FILENAME=fullfile(IMAGEPATH,IMAGEFILE);
IMG = double(imread (FILENAME));
NLIN=size(IMG,1);
NCOL=size(IMG,2);

II=1;

for LIN=1:(L/2):NLIN
for COL=1:(L/2):NCOL
if ((LIN+2*L-1)<=NLIN)&&((COL+2*L-1)<=NCOL)


    A=IMG(LIN:(LIN+2*L-1),COL:(COL+2*L-1)); 

    MIN=min(min(A));
    TT=(A==MIN);
    MEANTT=mean(mean(TT));

    if ( (MEANTT<0.3) )
        fprintf(stdout,"Line %5.2f :: Col %5.2f\n",100*LIN/(NLIN-2*L+1),100*COL/(NCOL-2*L+1));

        FATOR_PLANE=0.3;
        MIN_PER_BY=4;
        [CPl CPp Pc Acrop Agray LIMEAR]=func_get_spatial_frequency(A,FATOR_PLANE,MIN_PER_BY);

        if(length(CPl)!=0)
        DATACONF(II).Pl=CPl;
        DATACONF(II).Pp=CPp;
        DATACONF(II).Po=[LIN COL];
        DATACONF(II).D=2*L;
        II=II+1;
        endif

        figure(1);
        imagesc(Acrop);
        colormap(gray);
        daspect([1 1 1]);
        refresh(figure(1));

        figure(2);
        imagesc(A);
        daspect([1 1 1]);
        hold on
        if(length(CPl)!=0)
        for JJ=-1:1
            P0=Pc+JJ*CPp;
            quiver(P0(2),P0(1),CPl(2),CPl(1),'r','LineWidth',6);
        endfor
        endif
        hold off      
        colormap(gray);
        refresh(figure(2));


        figure(3);
        surf(Agray);
        shading interp
        colormap(jet);
        %hold on
        %surf(LIMEAR*ones(size(Agray)));
        %shading interp
        %hold off
        %view([-42.062 2.1034])
        view([0 -90])
        daspect([1 1 1]);
        refresh(figure(3));

        %input('******************************************');

        
    endif


endif
endfor
endfor

save([ IMAGEFILE '.datafile.dat'],'DATACONF')

