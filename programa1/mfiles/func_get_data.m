function [NCPl NCPp NCPc ]=func_get_data(Nx,Ny,DATA,WW)
    N=length(DATA);
    CPl= CPp=CPc=cell(N,1);
    D=zeros(N,1);

    for II=1:N
        [Pl Pp Pc ]=func_get_par(Nx,Ny,DATA{II});
        CPl{II}=Pl;
        CPp{II}=Pp;
        CPc{II}=Pc;
        D(II)=norm(Pp);
    endfor

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    NCPl= NCPp=NCPc=zeros(0,1);

    if(N>0)
        [MAX ID]=min(D);
        
        NCPl=CPl{ID};
        NCPp=CPp{ID};
        NCPc=CPc{ID};
    endif

endfunction

function [Pl Pp Pc ]=func_get_par(Nx,Ny,PAR)
    P1=PAR(1,:);
    P2=PAR(2,:);
    Pc=(P1+P2)/2;
    Pr=P2-Pc;

    if(norm(Pr)==0)
        error('Norm of Pr equalto zero!!');
    endif

    Pp=[Pr(1)/Nx Pr(2)/Ny]; Pp=Pp/norm(Pp)^2;
    Pl=Pp*[0 1;-1 0];
endfunction

