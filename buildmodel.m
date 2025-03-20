%
% Create logistic regression model from GEFS predictors
%
basin_type = 'all';
ri_defn = 30;
time_inc = 24;
missing = -999.9;
ti = 21;
flag_type = 'normal'; % 'optimize' or 'normal' options
if strcmp(flag_type, 'optimize')
    feat_ind_log = [1:54];
else
    if ti == 1 % t = 0  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 41 43 49 54]; % 20.9, p=6.4, n=3439, ri=218
        if strcmp(basin_type, 'EP')
            feat_ind_log = [31 34 41 49 54]; % 22.0, p=6.4, n=1619, ri=115
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [4 31 34 38 43 49 54]; % 21.5, p=6.4, n=1796, ri=103
        end
    elseif ti == 2 % t = 6  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 41 43 49 54]; % 21.0, p=6.1,n=3369, ri=205
        if strcmp(basin_type, 'EP')
            feat_ind_log = [31 34 41 49 54]; % 20.3, p=6.2, n=1591, ri=110
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [4 31 34 38 43 49 54]; % 27.0 24.5, p=6.1, n=1755, ri=95
        end
    elseif ti == 3 % t = 12  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 41 43 49 54]; % 17.0, p=6.1, n=3310, ri=200
        if strcmp(basin_type, 'EP')
            feat_ind_log = [31 34 41 49 54]; % 15.1, p=6.1, n=1558, ri=104
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [4 31 34 38 43 49 54]; % 21.8, p=6.0, n=1729, ri=96
        end
    elseif ti == 4 % t = 18  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 41 49 54]; % 18.8, p=6.1, n=3213, ri=194
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 31 34 41 49 54]; % 15.6, p=6.1, n=1526, ri=98
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [4 31 34 38 49 54]; % 23.2, p=6.0, n=1664, ri=96
        end
    elseif ti == 5 % t = 24  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 38 41 49 54]; % 15.1, p=5.8, n=3106, ri=179
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 31 34 41 49 54]; % 12.9 10.6, p=5.8, n=1481, ri=88
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 4 31 34 38 49 54]; % 21.3, p=5.7, n=1603, ri=91
        end
    elseif ti == 6 % t = 30  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 38 41 49 54]; % 17.3, p=5.6, n=2982, ri=167
        if strcmp(basin_type, 'EP')
            feat_ind_log = [31 34 38 41 49 54]; % 13.0, p=5.6, n=1429, ri=86
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 4 31 34 38 49 54]; % 23.1, p=5.6, n=1532, ri=81
        end
    elseif ti == 7 % t = 36  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 38 41 49 54]; % 13.6, p=5.6, n=2870, ri=160
        if strcmp(basin_type, 'EP')
            feat_ind_log = [31 34 38 41 49 54]; % 10.4, p=5.6, n=1374, ri=84
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 4 31 34 49 54]; % 18.6, p=5.5, n=1475, n=76
        end
    elseif ti == 8 % t = 42  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 38 41 49 54]; % 13.5, p=5.4, n=2761, ri=150
        if strcmp(basin_type, 'EP')
            feat_ind_log = [31 34 38 41 49 54]; % 11.4, p=5.5, n=1321, ri=77
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 4 31 34 49 54]; % 16.7, p=5.4, n=1419, ri=73
        end
    elseif ti == 9 % t = 48  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 38 41 49 54]; % 12.8, p=5.2, n=2639, ri=138
        if strcmp(basin_type, 'EP')
            feat_ind_log = [31 34 38 41 49 54]; % 9.2, p=5.2, n=1260, ri=72
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 4 31 34 49 54]; % 18.1, p=5.2, n=1359, ri=66
        end
    elseif ti == 10 % t = 54  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 38 41 49 54]; % 13.6, p=5.0, n=2491, ri=126
        if strcmp(basin_type, 'EP')
            feat_ind_log = [31 34 38 41 49 54]; % 10.1, p=5.1, n=1183, ri=64
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [4 31 34 41 49 54]; % 17.7, p=5.0, n=1289, ri=62
        end
    elseif ti == 11 % t = 60  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 41 49 54]; % 15.2, p=4.6, n=2382, ri=110
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 34 38 41 49 54]; % 13.5, p=4.6, n=1126, ri=54
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [4 31 34 41 49 54]; % 16.3, p=4.6, n=1237, ri=56
        end
    elseif ti == 12 % t = 66  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 41 49 54]; % 14.9, p=4.0, n=2252, ri=90
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 34 38 41 48 54]; % 9.6, p=4.0, n=1058, ri=44
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [4 31 34 41 49 54]; % 18.4, n=4.0, n=1176, ri=46
        end
    elseif ti == 13 % t = 72  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 41 49 54]; % 10.7, p=3.7, n=2134, ri=78
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 34 38 41 48 54]; % 8.0, p=3.7, n=998, ri=33
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [4 31 34 41 49 54]; % 14.8, p=3.7, n=1119, ri=45
        end
    elseif ti == 14 % t = 78  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 41 49 54]; % 7.8, p=3.2, n=2022, ri=65
        if strcmp(basin_type, 'EP')
            feat_ind_log = [2 34 38 41 48 54]; % 4.0, p=3.2, n=941, ri=23
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [4 31 34 41 49 54]; % 14.6, p=3.2, n=1065, ri=42
        end
    elseif ti == 15 % t = 84  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 41 49 54]; % 5.1, p=3.0, n=1911, ri=57
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 31 38 41 49 53]; % 0.7, p=3.0, n=942, ri=18
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [4 31 34 41 49 54]; % 12.6, p=3.0, n=1003, ri=39
        end
    elseif ti == 16 % t = 90  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 41 49 53 54]; % 5.3, p=2.9, n=1776, ri=51
        if strcmp(basin_type, 'EP')
            feat_ind_log = [31 41 49 53]; % 2.9, p=2.9, n=884, ri=13
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [4 31 34 41 49 54]; % 10.8, n=2.8, n=929, ri=38
        end
    elseif ti == 17 % t = 96  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [4 31 34 41 49 53 54]; % 7.5, p=2.7, n=1676, ri=45
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 31 41 49 53]; % 5.3, p=2.8, n=822, ri=12
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [4 31 34 41 49 54]; % 12.7, p=2.7, n=882, ri=33
        end
    elseif ti == 18 % t = 102 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [4 31 41 49 53 54]; % 5.1, p=2.3, n=1238, ri=27
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 31 41 49 53]; % 4.2, p=2.4, n=765, ri=9
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [4 31 34 41 49 54]; % 8.3, p=2.2, n=647, ri=20
        end
    elseif ti == 19 % t = 108 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [4 31 34 41 49 53 54]; % 10.7, p=1.9, n=1154, ri=21
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 31 34 41 49]; % 2.2, p=2.2, n=710, ri=7
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 4 31 34 41 49 54]; % 13.5, p=1.8, n=605, ri=15
        end
    elseif ti == 20 % t = 114 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [3 31 34 41 49 53 54]; % 8.9, p=1.7, n=1088, ri=18
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 31 34 41 49]; % 4.1, p=2.0, n=654, ri=4
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 4 31 34 41 54]; % 12.9, p=1.6, n=576, ri=14
        end
    elseif ti == 21 % t = 120 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [3 4 34 41 53 54]; % 6.2, p=1.3, n=1018, ri=14
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 31 34 41 49 53]; % 1.5, p=1.5, n=605, ri=2
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 4 34 41 54]; % 7.0, p=1.3, n=547, ri=12
        end
    end
end
%
meanpclim = [];
bssarray = [];
%
load all_variables_with_bt00.mat
vmaxbt = vmaxbt';
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
if strcmp(flag_type, 'normal')
    skill_test
    xf2 = feat_log;
    xfs = standardize(xf2);
    covm = xfs' * xfs / (length(xfs - 1));
elseif strcmp(flag_type, 'optimize')
    maxdev = chi2inv(0.95, 1);
    opt = statset('display', 'iter', 'TolFun', maxdev, ...
        'TolTypeFun', 'abs');
    inmodel = sequentialfs(@critfun, feat_log, ind_ri', ...
        'cv', 'none', 'nullmodel', true, ...
        'options', opt, 'direction', 'forward');
end
