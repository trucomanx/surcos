function [P0 WMAX CENTER]=func_find_centroids(IDMAP,W)
    IDMAX=max(max(IDMAP));

    P0=zeros(IDMAX,2);
    WMAX=zeros(IDMAX,1);
    N0=zeros(IDMAX,1);

    NLIN=size(IDMAP,1);
    NCOL=size(IDMAP,2);


    for LIN=1:NLIN
    for COL=1:NCOL
        ID=IDMAP(LIN,COL);
        if(ID!=0)
            P0(ID,:)=P0(ID,:)+[LIN COL];
            if W(LIN,COL)>WMAX(ID)
                WMAX(ID)=W(LIN,COL);
            endif
            N0(ID)=N0(ID)+1;
        endif
    endfor
    endfor
    
    idx=find(N0==0);
    P0(idx,:)=[];
    WMAX(idx)=[];
    N0(idx,:)=[];

    P0=[P0(:,1).*(1./N0) P0(:,2).*(1./N0)];

    L0=round(NLIN/2+1);
    C0=round(NCOL/2+1);
    CENTER=[L0 C0];
    IDd=func_find_close_to(P0,CENTER,1);
    P0(IDd,:)=[];
    WMAX(IDd)=[];
endfunction

