function [B C LIMEAR]=func_filter(A,fator)
    L=round(size(A,1)/2);
    A=A-mean(mean(A));

    FFT=fft2(A);
    FFTS=fftshift(FFT);
    
    M=32;
    DLINS=ceil((2*L+1)/2-M):floor((2*L+1)/2+M);
    DCOLS=ceil((2*L+1)/2-M):floor((2*L+1)/2+M);

    C=abs(FFTS(DLINS,DCOLS));

    %% FIltro mean
    C=conv2 (C, ones(3,3)/9);
    C=C(2:(end-1),2:(end-1));

%%%    %% Filtro picos
%%%    KK=[0 1 1 1 0;
%%%        1 2 2 2 1;
%%%        1 2 4 2 1;
%%%        1 2 2 2 1;
%%%        0 1 1 1 0];
%%%    KK=KK/sum(sum(KK));    
%%%    C=conv2 (C, KK);
%%%    C=C(3:(end-2),3:(end-2));

    KK=[0 0 1 1 1 0 0;
        0 1 3 3 3 1 0;
        1 3 6 6 6 3 1;
        1 3 6 9 6 3 1;
        1 3 6 6 6 3 1;
        0 1 3 3 3 1 0;
        0 0 1 1 1 0 0];
    D=func_corr2(C,KK);
    C=C.*D;


    C(M+1,M+1)=( C(M,M+1)+C(M+2,M+1)+C(M+1,M)+C(M+1,M+2) )/4;

    %C=conv2(C,[1 1 1;1 1 1;1 1 1]);
    MAX=max(max(C));
    MIN=min(min(C));

    STD=sqrt(mean(var(C)));
    MEAN=mean(mean(C));

    LIMEAR=(MIN+fator*(MAX-MIN));

    B=double(C>LIMEAR);

endfunction
