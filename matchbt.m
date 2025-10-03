%
for il = 0:0
    if il < 10
        imem = ['0' num2str(il)];
    else
        imem = num2str(il);
    end
    load(['all_variables00.mat'])
    load bt_all
    stnum = str2num(stnum);
    %
    yr = str2num(forInit(:,1:4));
    mo = str2num(forInit(:,5:6));
    da = str2num(forInit(:,7:8));
    hr = str2num(forInit(:,9:10));
    %
    time_all = datenum(yr, mo, da, hr, hr * 0, hr * 0);
    basin = cellstr(basin);
    %
    [nf, nt] = size(cape1);
    vmaxbt = NaN(nf, nt);
    for i = 1:nt
        for j = 1:nf
            ind = find((stnum(i) == stnum_bt) & ...
                (time_all(i) + (j-1)*0.25 == time_bt) & ...
                strcmp(basin(i), basin_bt));
            if ~isempty(ind)
                vmaxbt(j, i) = vmax_bt(ind(1));
            end
        end
    end
    %convert_preds
    [nl, nt] = size(cape1);
    all_preds = zeros(nt, nl, 53);
    %
    all_preds(:, :, 1) = cape1';
    all_preds(:, :, 2) = cape2';
    all_preds(:, :, 3) = cape3';
    all_preds(:, :, 4) = dvrg200';
    all_preds(:, :, 5) = ike1';
    all_preds(:, :, 6) = ike2';
    all_preds(:, :, 7) = ir1';
    all_preds(:, :, 8) = ir2';
    all_preds(:, :, 9) = ir3';
    all_preds(:, :, 10) = ir4';
    all_preds(:, :, 11) = ir5';
    all_preds(:, :, 12) = ir6';
    all_preds(:, :, 13) = ir7';
    all_preds(:, :, 14) = ir8';
    all_preds(:, :, 15) = ir9';
    all_preds(:, :, 16) = ir10';
    all_preds(:, :, 17) = ir11';
    all_preds(:, :, 18) = ir12';
    all_preds(:, :, 19) = ir13';
    all_preds(:, :, 20) = ir14';
    all_preds(:, :, 21) = ir15';
    all_preds(:, :, 22) = ir16';
    all_preds(:, :, 23) = land';
    all_preds(:, :, 24) = lat';
    all_preds(:, :, 25) = lon';
    all_preds(:, :, 26) = min_slp';
    all_preds(:, :, 27) = pers';
    all_preds(:, :, 28) = rhhi';
    all_preds(:, :, 29) = rhlo';
    all_preds(:, :, 30) = rhmd';
    all_preds(:, :, 31) = rmw';
    all_preds(:, :, 32) = shr_hdg';
    all_preds(:, :, 33) = shr_mag';
    all_preds(:, :, 34) = shr_ships';
    all_preds(:, :, 35) = sst';
    all_preds(:, :, 36) = stm_hdg';
    all_preds(:, :, 37) = stm_spd';
    all_preds(:, :, 38) = t200';
    all_preds(:, :, 39) = tang850';
    all_preds(:, :, 40) = tgrd';
    all_preds(:, :, 41) = tpw';
    all_preds(:, :, 42) = usfc1';
    all_preds(:, :, 43) = usfc2';
    all_preds(:, :, 44) = usfc3';
    all_preds(:, :, 45) = usfcsym1';
    all_preds(:, :, 46) = usfcsym2';
    all_preds(:, :, 47) = usfcsym3';
    all_preds(:, :, 48) = vmax';
    all_preds(:, :, 49) = vmpi';
    all_preds(:, :, 50) = vort850';
    all_preds(:, :, 51) = w8501';
    all_preds(:, :, 52) = w8502';
    all_preds(:, :, 53) = w8503';
    clear w* vmpi vort850 vmax u* pw tgrd tang850 t200
    clear stm* sst shr* rmw rh* p* ir* lat lon min_slp cape* dvrg*
    clear ike* tpw land
    clear i j nt nf ind nl basin_bt vmax_bt time_bt stnum_bt mo da hr
    clear yr
    save(['all_variables_with_bt' imem '.mat'], 'time_all', ...
        'stnum', 'basin', 'all_preds', 'vmaxbt', 'forInit')
    
end
