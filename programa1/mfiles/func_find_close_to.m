function ID=func_find_close_to(P0,Pa,DIST)
    N=size(P0,1);
    D=zeros(N,1);

    for II=1:N
    D(II)=norm(P0(II,:)-Pa);
    endfor
    ID=find(D<=DIST);
endfunction
