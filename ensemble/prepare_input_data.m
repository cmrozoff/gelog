%
% Go through each ensemble member to make a forecast
reduced_f = NaN(37, 54, 31);
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
    % Prepare predictors for model
    nt = length(dvmax_bt_f_mem);
    reduced = NaN(nt, 54);
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
    end
    reduced(:, 54) = dvmax_model_f_mem;
    clear i j
    reduced_f(:, :, imember) = reduced;
end
clear reduced a b ind_ri_f_mem vmax_model_f