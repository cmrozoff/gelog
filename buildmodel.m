%
% Create logistic regression model from GEFS predictors
%
basin_type = 'AL'
ri_defn = 30;
time_inc = 24;
missing = -999.9;
ti = 1;
flag_type = 'normal'; % 'optimize' or 'normal' options
if strcmp(flag_type, 'optimize')
    feat_ind_log = [1:54];
else
    if ti == 1 % t = 0  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 41 43 54 55]; % 22.3, p=6.5, n=3514, ri=227 %
        if strcmp(basin_type, 'EP')
            feat_ind_log = [31 34 41 54 55]; % 21.9, p=6.6, n=1623, ri=115 %
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [4 31 34 38 43 54 55]; % 22.7, p=6.5, n=1867, ri=112 %
        end
    elseif ti == 2 % t = 6  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 41 43 54 55]; % 21.9, p=6.2,n=3439, ri=213 % 
        if strcmp(basin_type, 'EP')
            feat_ind_log = [31 34 41 54 55]; % 20.4, p=6.3, n=1594, ri=110 %
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [4 31 34 38 43 54 55]; % 24.5, p=6.2, n=1822, ri=103 %
        end
    elseif ti == 3 % t = 12  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 41 43 54 55]; % 17.8, p=6.2, n=3376, ri=207 %
        if strcmp(basin_type, 'EP')
            feat_ind_log = [31 34 41 54 55]; % 15.1, p=6.2, n=1560, ri=104 %
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [4 31 34 38 43 54 55]; % 21.7, p=6.1, n=1793, ri=103 %
        end
    elseif ti == 4 % t = 18  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 41 54 55]; % 20.0, p=6.1, n=3274, ri=200 %
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 31 34 41 54 55]; % 16.4, p=6.2, n=1527, ri=98 %
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [4 31 34 38 54 55]; % 24.0, p=6.1, n=1724, ri=102 %
        end
    elseif ti == 5 % t = 24  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 38 41 54 55]; % 15.4, p=5.8, n=3162, ri=184 %
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 31 34 41 54 55]; % 11.0, p=5.9, n=1481, ri=88 %
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 4 31 34 38 54 55]; % 20.7, p=5.8, n=1659, ri=96 %
        end
    elseif ti == 6 % t = 30  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 38 41 54 55]; % 17.9, p=5.7, n=3036, ri=172 %
        if strcmp(basin_type, 'EP')
            feat_ind_log = [31 34 38 41 54 55]; % 13.8, p=5.7, n=1429, ri=86 %
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 4 31 34 38 54 55]; % 23.5, p=5.6, n=1586, ri=86 % 
        end
    elseif ti == 7 % t = 36  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 38 41 54 55]; % 13.7, p=5.6, n=2920, ri=164 %
        if strcmp(basin_type, 'EP')
            feat_ind_log = [31 34 38 41 54 55]; % 10.7, p=5.7, n=1374, ri=84 %
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 4 31 34 54 55]; % 19.3, p=5.6, n=1525, n=80 %
        end
    elseif ti == 8 % t = 42  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 38 41 54 55]; % 13.5, p=5.4, n=2807, ri=152 %
        if strcmp(basin_type, 'EP')
            feat_ind_log = [31 34 38 41 54 55]; % 11.8, p=5.4, n=1321, ri=77 %
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 4 31 34 54 55]; % 16.1, p=5.4, n=1465, ri=75 %
        end
    elseif ti == 9 % t = 48  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 38 41 54 55]; % 13.3, p=5.2, n=2683, ri=140 %
        if strcmp(basin_type, 'EP')
            feat_ind_log = [31 34 38 41 54 55]; % 9.5, p=5.2, n=1260, ri=72 %
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 4 31 34 54 55]; % 17.6, p=5.2, n=1403, ri=68 % 
        end
    elseif ti == 10 % t = 54  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 38 41 54 55]; % 14.7, p=5.0, n=2533, ri=128 %
        if strcmp(basin_type, 'EP')
            feat_ind_log = [31 34 38 41 54 55]; % 9.7, p=5.1, n=1183, ri=64 %
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [4 31 34 41 54 55]; % 18.3, p=5.0, n=1331, ri=64 %
        end
    elseif ti == 11 % t = 60  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 41 54 55]; % 14.9, p=4.6, n=2423, ri=112 %
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 34 38 41 54 55]; % 12.9, p=4.6, n=1126, ri=54 %
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [4 31 34 41 54 55]; % 17.9, p=4.6, n=1278, ri=58 %
        end
    elseif ti == 12 % t = 66  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 41 54 55]; % 15.0, p=4.0, n=2288, ri=92 %
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 34 38 41 48 54]; % 9.3, p=4.0, n=1058, ri=44 %
        elseif strcmp(basin_type, 'AL') 
            feat_ind_log = [4 31 34 41 54 55]; % 20.5, n=4.0, n=1212, ri=48 %
        end
    elseif ti == 13 % t = 72  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 41 54 55]; % 10.5, p=3.6, n=2167, ri=79 %
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 34 38 41 48 54]; % 7.9, p=3.6, n=998, ri=33 %
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [4 31 34 41 54 55]; % 15.9, p=3.7, n=1152, ri=46 %
        end
    elseif ti == 14 % t = 78  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 41 54 55]; % 7.0, p=3.1, n=2056, ri=65 %
        if strcmp(basin_type, 'EP')
            feat_ind_log = [2 34 38 41 48 54]; % 3.7, p=3.1, n=941, ri=23 %
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [4 31 34 41 54 55]; % 14.1, p=3.1, n=1098, ri=42 %
        end
    elseif ti == 15 % t = 84  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 41 54 55]; % 4.7, p=2.9, n=1942, ri=57 %
        if strcmp(basin_type, 'EP')
            feat_ind_log = [2 31 34 38 41 48]; % 4.7, p=2.9, n=942, ri=18 %
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [4 31 34 41 54 55]; % 12.7, p=2.9, n=1034, ri=39 %
        end
    elseif ti == 16 % t = 90  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [31 34 41 53 54 55]; % 5.0, p=2.8, n=1804, ri=51 %
        if strcmp(basin_type, 'EP')
            feat_ind_log = [2 31 41 53 55]; % 2.5, p=2.8, n=884, ri=13 %
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [4 31 34 41 54 55]; % 10.9, p=2.8, n=957, ri=38 %
        end
    elseif ti == 17 % t = 96  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [4 31 41 53 54 55]; % 6.4, p=2.7, n=1703, ri=45 %
        if strcmp(basin_type, 'EP')
            feat_ind_log = [2 31 41 53 55]; % 5.0, p=2.7, n=822, ri=12 %
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [4 31 34 41 54 55]; % 12.0, p=2.6, n=909, ri=33 %
        end
    elseif ti == 18 % t = 102 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [4 31 41 53 54 55]; % 5.2, p=2.2, n=1263, ri=27 %
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 31 41 53 55]; % 3.5, p=2.4, n=765, ri=9 %
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [4 31 34 41 54 55]; % 7.7, p=2.1, n=672, ri=20 %
        end
    elseif ti == 19 % t = 108 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [4 31 34 41 53 54 55]; % 12.3, p=1.8, n=1177, ri=21 %
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 31 41 53 55]; % 2.5, p=2.2, n=710, ri=7 %
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 4 31 34 41 54 55]; % 15.7, p=1.8, n=628, ri=15 %
        end
    elseif ti == 20 % t = 114 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [3 31 34 41 53 54 55]; % 10.0, p=1.6, n=1109, ri=18 %
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 31 34 41 55]; % 3.9, p=1.9, n=654, ri=4 %
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 4 31 34 41 54 55]; % 18.5, p=1.6, n=597, ri=14 %
        end
    elseif ti == 21 % t = 120 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        feat_ind_log = [3 4 34 41 53 54]; % 7.2, p=1.3, n=1038, ri=14 %
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 31 41 53 55]; % 2.5, p=1.5, n=605, ri=2 %
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 4 34 41 54]; % 7.7, p=1.3, n=567, ri=12 %
        end
    end
end
%
meanpclim = [];
bssarray = [];
%
load all_variables_with_bt00.mat
mpi_calc_iships
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
reduced = NaN(ncases, nt, nfeat+2);
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
    reduced(:, j, 55) = nanmean(rmpi(:, j:j+nlt), 2);
end
%
reduced(:, :, 54) = dvmax_model;
% 
% Scatter diagrams
% clf;figure(1);
% scatter(dvmax_bt, reduced(:, :, 54)) % 43 usfc 2 ; 4 DIV 34 Shear 31 RMW 55 MPI
% xlim([-100 100])
% xlabel('24-h \Delta v observed (kt)')
% %ylabel('MPI (kt)')
% %ylabel('RMW (km)')
% %ylabel('Shear (kt)')
% %ylabel('Divergence')
% %ylabel('10-m U at 100-200 km  (m/s)')
% ylabel('24-h \Delta v model (kt)')
% keyboard
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
