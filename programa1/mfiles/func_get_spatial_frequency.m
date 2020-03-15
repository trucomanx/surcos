function [CPl CPp Pc Acrop Agray LIMEAR]=func_get_spatial_frequency(A,FATOR,MIN_PER_BY)
    [Acrop Agray LIMEAR]=func_filter(A,FATOR);

    [DATA WW]=func_cumulos(Acrop,Agray,MIN_PER_BY);
    LINA=size(A,1);
    COLA=size(A,2);
    %[CPl CPp CPc ]=func_get_data(LINA,COLA,DATA,WW);
    [CPl CPp CPc ]=func_get_data_max(LINA,COLA,DATA,WW);
    Pc=[round(LINA/2)+1,round(COLA/2)+1];        
endfunction
