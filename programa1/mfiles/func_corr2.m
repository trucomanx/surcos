function B=func_corr2(A,KK)
    if (size(KK,1)!=size(KK,2))
        error('KK is not a square matrix.');
    endif
    if (mod(size(KK,1),2)!=1)
        error('The KK matrix dont have a odd size.');
    endif

    
    B=zeros(size(A));
    NLIN=size(A,1);
    NCOL=size(A,2);

    
    L=(size(KK,1)-1)/2;

    for LIN=1:(NLIN-2*L)
    for COL=1:(NCOL-2*L)
        B(LIN+L,COL+L)=corr2(A(LIN:(LIN+2*L),COL:(COL+2*L)),KK);
    endfor
    endfor
    

endfunction
