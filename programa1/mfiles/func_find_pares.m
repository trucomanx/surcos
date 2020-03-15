function [PARES WW DIST]=func_find_pares(P0,WMAX,CENTER,DIST_UMBRAL)
    N=size(P0,1);
    N2=floor(N/2);

    PARES=cell(N2,1);
    WW=cell(N2,1);
    DIST=zeros(N2,1);


    II=1;
    while size(P0,1)>0
        Pt1=P0(1,:);
        P0(1,:)=[];

        WMAX1=WMAX(1);
        WMAX(1)=[];

        IDd=func_find_close_to(P0,2*CENTER-Pt1,1);%% menores a un pixel
        D=norm(Pt1-CENTER);

        if ((length(IDd)>0)&&(D>DIST_UMBRAL) )
            Pt2=P0(IDd,:);
            P0(IDd,:)=[];

            PARES{II}=[Pt1;Pt2];

            WMAX2=WMAX(IDd);
            WMAX(IDd)=[];

            DIST(II)=norm(CENTER-Pt2)*0.5+norm(CENTER-Pt1)*0.5;

            WW{II}=(WMAX1+WMAX2)/2;
            II=II+1;
        endif 
    endwhile
    
    IDS=find(DIST==0);
    PARES(IDS)=[];
    DIST(IDS)=[];
    WW(IDS)=[];

endfunction
