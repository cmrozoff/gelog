%
% Eliminate testing year
%
[yr, mo, da, hr, mn, sc] = datevec(time_all);
%
ind = find(yr ~= str2num(yr_f));
%
clear yr mo da hr mn sc
%
time_all = time_all(ind);
vmaxbt = vmaxbt(ind, :);
basin = basin(ind);
stnum = stnum(ind);
all_preds = all_preds(ind, :, :);
%
clear ind
%
% ----------------------------------------------------------------------
% Identify grid points where the storm is over land and set to missing.
%  Also, turn -999.9 to NaN
%
[all_preds, nfeat] = elim_land_pts(all_preds, missing);
clear missing
%
% Create an RI and a non-RI set
[ind_ri, dvmax_bt, dvmax_model, nlt] = ...
    define_ri(time_inc, all_preds, vmaxbt, ri_defn);
[nc, nl] = size(ind_ri);
%
% Prepare predictors for model
[ncases, nt] = size(dvmax_bt);
reduced = NaN(ncases, nt, nfeat+1);
disp(' ')
%disp('Manipulating predictors')
for j = 1:nt
    for i = 1:6
    	reduced(:, j, i) = nanmean(all_preds(:, j:j+nlt, i), 2);
    end
    for i = 7:22
        reduced(:, j, i) = all_preds(:, 1, i); % Use t = 0 values (IR preds)
    end
    for i = 23:26
        reduced(:, j, i) = nanmean(all_preds(:, j:j+nlt, i), 2);
    end
    reduced(:, j, 27) = all_preds(:, 1, 27); % Use t = 0 value (Persistence)
    for i = 28:53
        reduced(:, j, i) = nanmean(all_preds(:, j:j+nlt, i), 2);
    end
end
%
reduced(:, :, 54) = dvmax_model;
%
clear all_preds i j
%
% Reduce dataset dataset down to the features specified in feat_ind_log
feat_log = [];
nfeat = length(feat_ind_log);
feat_log = NaN(ncases, nt, nfeat);
%
for j = 1:nt
    for i = 1:nfeat
        feat_log(:, j, i) = reduced(:, j, feat_ind_log(i));
    end
end
%
% Fix lead-time to ti
feat_log = squeeze(feat_log(:, ti, :));
ind_ri = squeeze(ind_ri(:, ti));
vmaxbt = squeeze(vmaxbt(:, ti));
%
% Get rid of data that have missing values
feat_log2 = []; ind_ri2 = []; time2 = []; vmaxbt2 = []; basin2 = {};
%
%disp('Getting rid of missing data')
%
j = 0;
for i = 1:ncases
    ind = find(isnan(feat_log(i, :)) | isnan(ind_ri(i)));
    if isempty(ind)
        j = j + 1;
        feat_log2(j, :) = feat_log(i, :);
        ind_ri2(j) = ind_ri(i);
        vmaxbt2(j) = vmaxbt(i);
        basin2{j} = basin{i};
        time2 = [time2 ; time_all(i)];
    end
end
%
feat_log = feat_log2;
ind_ri = ind_ri2;
time_all = time2;
vmaxbt = vmaxbt2;
basin = basin2;
clear *2 i j ind reduced stnum forInit nlt nt nl nfeat
clear mn nc ncases dvmax* sc
%
feat_train = feat_log;
flag_train = ind_ri';
ind_train_ri = find(flag_train > 0);
pclim = length(ind_train_ri) / length(flag_train);
%

