%
% Go through each ensemble member to make a forecast
reduced_f = NaN(37, 55, 31);
for imember = 1:31
    disp(['Making forecast for ensemble member ' num2str(imember)])
    if imember - 1 < 10
        imem = ['0' num2str(imember - 1)];
    else
        imem = num2str(imember - 1);
    end
    %
    % Create an RI and a non-RI set
    nlt = time_inc / 6.0;
    vmax_model_f = all_preds_f(:, 48, imember);
    %
    ntimes = length(vmax_model_f);
    ind_ri_f_mem = NaN(ntimes - nlt, 1);
    dvmax_bt_f_mem = NaN(ntimes - nlt, 1);
    dvmax_model_f_mem = NaN(ntimes - nlt, 1);
    for i = 1:(ntimes - nlt)
        dvmax_bt_f_mem(i) = vmaxbt_f(i + nlt) - vmaxbt_f(i);
        dvmax_model_f_mem(i) = vmax_model_f(i + nlt) - vmax_model_f(i);
        if (dvmax_bt_f_mem(i) >= ri_defn)
            ind_ri_f_mem(i) = 1.0;
        end
        if (dvmax_bt_f_mem(i) < ri_defn);
            ind_ri_f_mem(i) = 0.0;
        end
    end
    %
    % Calculate iships.f MPI
    %
    % MPI Calculation
    vmax = all_preds_f(:, 48, imember);
    vmpi = all_preds_f(:, 49, imember);
    cmagt = all_preds_f(:, 37, imember);
    sst = all_preds_f(:, 35, imember);
    rmpi = sst*0.0;
    ind = find(sst < 0);
    rmpi(ind) = NaN;

    % if basin=='AL'
    % DeMaria and Kaplan (1994)
    vcold = 28.2;
    vadd  = 55.8;
    a     = 0.1813;
    tmax  = 30.0;
    %
    ind = find(sst >= 0 & strcmp(basin_f, 'AL'));
    rmpi(ind) = vcold + vadd*exp(-a*(tmax-sst(ind)));
    rmpi(ind) = rmpi(ind)*1.944;
    % elseif basin=='EP'
    %East Pacific function (Whitney and Hobgood 1997)
    a = -79.2;
    b = 5.362;
    c = 0.0;
    %
    tmin = 20.0;

    %
    ind = find(sst >= 0 & (strcmp(basin_f, 'EP') | (strcmp(basin_f, 'CP'))));
    sstt = sst;
    sstt(ind) = sst(ind);
    indtmin = find(sstt < tmin & sstt >= 0);
    sstt(indtmin) = tmin;
    rmpi(ind) = a + b*sstt(ind) + c;
    rmpi(ind) = rmpi(ind)*1.944;
    %end
    ind165 = find(rmpi > 165.0);
    rmpi(ind165) = 165.0;
    ind0 = find(rmpi < 0);
    rmpi(ind0) = 0.0;
    clear ind165 ind ind0
    rmpi_old = rmpi;
    %
    indboth = find(cmagt > 0 & rmpi > 0);
    ind40 = find(cmagt > 40);
    cmagt(ind40) = 40.0;
    cadj = 0.0 * rmpi; % Allocate array
    cadj(indboth) = 1.5 * (cmagt(indboth).^0.63);
    rmpi(indboth) = rmpi(indboth) + cadj(indboth);

    % Prepare predictors for model
    nt = length(dvmax_bt_f_mem);
    reduced = NaN(nt, 55);
    for j = 1:nt
        for i = 1:6
        	reduced(j, i) = nanmean(all_preds_f(j:j+nlt, i, imember));
        end
        for i = 23:26
            reduced(j, i) = nanmean(all_preds_f(j:j+nlt, i, imember));
        end
        reduced(j, 24) = all_preds_f(j, 24, imember);
        reduced(j, 25) = all_preds_f(j, 25, imember);
        reduced(j, 27) = all_preds_f(1, 27); % Use t = 0 value (Persistence)
        for i = 28:53
            reduced(j, i) = nanmean(all_preds_f(j:j+nlt, i, imember));
        end
        reduced(j, 55) = nanmean(rmpi(j:j+nlt));
    end
    reduced(:, 54) = dvmax_model_f_mem;
    clear i j
    reduced_f(:, :, imember) = reduced;
end
clear reduced a b ind_ri_f_mem vmax_model_f