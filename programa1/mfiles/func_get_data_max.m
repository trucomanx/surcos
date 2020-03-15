function [Pl Pp Pc ]=func_get_data_max(Nx,Ny,DATA,WW)
    N=length(DATA);
    Pl=Pp=Pc=zeros(0,2);

    if(N!=0)
        [MAX IDMAX]=max([WW{:}]);

        [Pl Pp Pc ]=func_get_par(Nx,Ny,DATA{IDMAX});
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
