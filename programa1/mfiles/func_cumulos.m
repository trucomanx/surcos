function [DATA WW]=func_cumulos(B,W,MIN_PERIOD_BY)

    C = Cumulus(B);

    [MAP ID WID]= C.calculate_cumulus();

    fprintf(stdout,"\n");

    [P0 WMAX CENTER]=func_find_centroids(MAP,W);

    [DATA WW DIST]=func_find_pares(P0,WMAX,CENTER,MIN_PERIOD_BY);

endfunction


