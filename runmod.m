%
% Create logistic regression model from GEFS predictors
%
basin_type = 'all';
ri_defn = 30;
time_inc = 24;
missing = -999.9;
feat_ind_log = [1:54]; % User set parameters. See read_preds.m
                       % for "key" of what parameters are

flag_type = 'normal'; % 'optimize' or 'normal' options
meanpclim = [];
bssarray = [];
for ti = 1:21
    if ti == 1
        feat_ind_log = [31 34 41 49 54]; % t = 0 19.9 (1)
        if strcmp(basin_type, 'EP')
            feat_ind_log = [31 34 41 49 54]; % 19.1
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [31 34 41 49 54]; % 23.4
        end
    elseif ti == 2
        feat_ind_log = [4 31 34 41 43 49 54]; % t = 6 21.2 (2)
        if strcmp(basin_type, 'EP')
            feat_ind_log = [4 31 34 41 43 49 54]; % 20.0
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [31 33 35 38 43 49 54]; % 27.0
        end
    elseif ti == 3
        feat_ind_log = [31 34 41 49 54]; % t = 12 16.3 (3)
        if strcmp(basin_type, 'EP')
            feat_ind_log = [31 34 41 49 54]; % 15.1
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [4 31 33 35 38 49 54]; % 22.1
        end
    elseif ti == 4
        feat_ind_log = [3 31 34 41 49 54]; % t = 18 17.7 (4)
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 4 31 34 41 49 54]; % 15.9
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [31 33 35 38 49 54]; % 26.8
        end
    elseif ti == 5
        feat_ind_log = [3 31 34 38 41 49 54]; % t = 24 13.5 (5)
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 31 34 38 41 49 54]; % 12.9
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [31 33 35 38 49 54]; % 22.0
        end
    elseif ti == 6
        feat_ind_log = [3 31 34 38 41 49 54]; % t = 30 14.8 (6)
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 31 34 38 41 49 54]; % 12.1
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 31 33 35 38 49 54]; % 30.2
        end
    elseif ti == 7
        feat_ind_log = [3 31 34 38 41 49 54]; % t = 36 12.0 (7)
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 31 34 38 41 49 54]; % 10.3
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 31 33 35 49 54]; % 21.8
        end
    elseif ti == 8
        feat_ind_log = [3 4 31 34 38 49 54]; % t = 42 11.6 (8)
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 4 31 34 38 49 54]; % 9.9
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 31 33 35 49 54]; % 22.5
        end
    elseif ti == 9
        feat_ind_log = [3 31 34 38 49 54]; % t = 48 11.9 (9)
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 31 34 38 49 54]; % 11.0
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 31 33 35 48 54]; % 21.6
        end
    elseif ti == 10
        feat_ind_log = [3 31 34 38 49 54]; % t = 54 10.9 (10)
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 31 34 38 49 54]; % 10.7
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 31 33 35 41 49 54]; % 17.0
        end
    elseif ti == 11
        feat_ind_log = [3 31 33 35 38 49 54]; % t = 60 12.1 (11)
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 34 38 48 54]; % 12.1
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 4 31 33 35 41 49 54]; % 14.4
        end
    elseif ti == 12
        feat_ind_log = [33 35 38 42 45 48 50 54]; % t = 66; b = 10.3 (12)
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 34 38 41 45 48 50 54]; % 9.8
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 31 34 41 49 54]; % 19.2
        end
    elseif ti == 13
        feat_ind_log = [3 31 34 38 41 48 54]; % t = 72; b = 6.6 (13)
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 31 34 38 41 48 54]; % 5.8
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 31 34 41 49 54]; % 12.6
        end
    elseif ti == 14
        feat_ind_log = [3 31 34 38 41 48 54]; % t = 78 ; b = 5.2 (14)
        if strcmp(basin_type, 'EP')
            feat_ind_log = [2 34 38 41 48 54]; % 4.7
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 31 34 41 49 54]; % 8.1
        end
    elseif ti == 15
        feat_ind_log = [34 38 41 48 54]; % t = 84 ; b = 3.0 (15)
        if strcmp(basin_type, 'EP')
            feat_ind_log = [2 34 38 41 48 54]; % 3.1
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [2 34 49 54]; % 6.2
        end
    elseif ti == 16
        feat_ind_log = [34 38 42 43 48 54]; % t = 90 b = 2.3 (16)
        if strcmp(basin_type, 'EP')
            feat_ind_log = [31 38 49 54]; % 0.7
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 4 31 34 49 54]; % 8.7
        end
    elseif ti == 17
        feat_ind_log = [3 34 38 42 43 48 54]; % t = 96; b = 2.5 (17)
        if strcmp(basin_type, 'EP')
            feat_ind_log = [31 38 49 54]; % 1.4
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 4 31 34 38 49 54]; % 9.7
        end
    elseif ti == 18
        feat_ind_log = [3 4 31 34 38 41 54]; % t = 102; b = 1.8 (18)
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 31 49 54]; % 0.9
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 4 31 34 38 54]; % 3.5
        end
    elseif ti == 19
        feat_ind_log = [4 31 34 41 54]; % t = 108; b = 1.9 (19)
        %
        if strcmp(basin_type, 'EP')
            feat_ind_log = [4 31 41 49 54]; % 3.7
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [4 31 34 41 54]; % 2.3
        end
    elseif ti == 20
        feat_ind_log = [3 4 31 34 41 54]; % t = 114; b = 1.8 (20)
        %
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 31 41 49]; % 0.7 %
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 4 31 34 41 54]; % 5.2
        end
    elseif ti == 21
        feat_ind_log = [3 4 31 34 41 54]; % t = 120; b = 2.6 (21) 4772
        %
        if strcmp(basin_type, 'EP')
            feat_ind_log = [3 31 34 41 49]; % 2.1
        elseif strcmp(basin_type, 'AL')
            feat_ind_log = [3 4 31 34 41 54]; % 8.2
        end
    end
    %

    %
    load all_variables_with_bt00.mat
    vmaxbt = vmaxbt';
    % %
    % % Restrict basin
    % if strcmp(basin_type, 'AL') || strcmp(basin_type, 'EP')
    %     ind = find(strcmp(basin, basin_type));
    %     all_preds = all_preds(ind, :, :);
    %     forInit = forInit(ind, :);
    %     stnum = stnum(ind);
    %     time_all = time_all(ind);
    %     vmaxbt = vmaxbt(ind, :);
    % end
    % ----------------------------------------------------------------------
    %
    % Identify grid points where the storm is over land and set to missing.
    %  Also, turn -999.9 to NaN
    %
    [all_preds, nfeat] = elim_land_pts(all_preds, missing);
    clear missing
    %
    % Create an RI and a non-RI set
    [ind_ri, dvmax_bt, dvmax_model, nlt] = ...
        define_ri(time_inc, all_preds, vmaxbt, ri_defn);
    %
    % Prepare predictors for model
    [ncases, nt] = size(dvmax_bt);
    reduced = NaN(ncases, nt, nfeat+1);
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
    % Get rid of data that have missing values
    feat_log2 = []; ind_ri2 = []; time2 = []; vmaxbt2 = []; basin2 = {};
    %
    %disp('Getting rid of missing data')
    for k = 1:nt
        j = 0;
        for i = 1:ncases
            ind = find(isnan(feat_log(i, k, :)));
            if isempty(ind)
                j = j + 1;
                feat_log2(j, k, :) = feat_log(i, k, :);
                ind_ri2(j, k) = ind_ri(i, k);
                vmaxbt2(j, k) = vmaxbt(i, k);
                basin2{j} = basin{i};
                if k == 1;
                    time2 = [time2 ; time_all(i)];
                end
            end
        end
    end
    feat_log = feat_log2;
    ind_ri = ind_ri2;
    time_all = time2;
    vmaxbt = vmaxbt2;
    basin = basin2;
    clear *2 i j ind reduced
    if strcmp(flag_type, 'normal')
        feat_log = squeeze(feat_log(:, ti, :));
        ind_ri = ind_ri(:, ti);
        skill_test
        xf2 = feat_log;
        xfs = standardize(xf2);
        covm = xfs' * xfs / (length(xfs - 1));
    elseif strcmp(flag_type, 'optimize')
        for i = ti:ti+nlt
            maxdev = chi2inv(0.95, 1);
            opt = statset('display', 'iter', 'TolFun', maxdev, ...
                'TolTypeFun', 'abs');
            inmodel = sequentialfs(@critfun, squeeze(feat_log(:, i, :)), ind_ri(:, i), ...
                'cv', 'none', 'nullmodel', true, ...
                'options', opt, 'direction', 'forward');
        end
    end
end