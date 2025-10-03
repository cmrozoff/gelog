%
% Script to cross-validate and get model's Brier skill scorexs
%
[yr, mo, da, hr, mn, sc] = datevec(time_all);
clear mo da hr mn sc
%
yr_span = unique(yr);
%
post_p_log = [];
flag_test = [];
p_clim_all = [];
%
for iyr = 1:length(yr_span)
    %disp(['Working on year ' num2str(yr_span(iyr))])
    ind_training = find(yr ~= yr_span(iyr));
    ind_testing = find(yr == yr_span(iyr));
    %
    feat_train = feat_log(ind_training, :);
    feat_test = feat_log(ind_testing, :);
    basin_test = basin(ind_testing);
    if strcmp(basin_type, 'AL') || strcmp(basin_type, 'EP')
        ind = squeeze(find(strcmp(basin_test, basin_type)));
        feat_test = feat_test(ind, :);
        ind_testing = ind_testing(ind);
    end
    %
    flag_train = ind_ri(ind_training)';
    %
    ind_train_ri = find(flag_train > 0);
    pclim = length(ind_train_ri) / length(ind_training);
    %
    plog = logist_classifier_func(feat_train, flag_train, feat_test);
    %
    post_p_log = [post_p_log ; plog];
    %
    flag_test = [flag_test ; ind_ri(ind_testing)'];
    p_clim_all = [p_clim_all ; pclim * ones(length(ind_testing), 1)];
    %p_clim_all = [p_clim_all ; 0.046 * ones(length(ind_testing), 1)];
end
%
%disp(' ')
%disp(' Results of the testing. ')
BS = sum( (post_p_log - flag_test) .^ 2);
BSref = sum( (p_clim_all - flag_test) .^ 2);
BSS = 1 - BS / BSref;
disp(['BSS = ' num2str(BSS*100) ' at iteration ' num2str(ti)])
disp(['mean pclim = ' num2str(100*mean(p_clim_all))])
disp(['num test cases = ' num2str(length(p_clim_all))])
disp(['num RI cases = ' num2str(sum(flag_test))])
meanpclim = [meanpclim ; 100*mean(p_clim_all)];
bssarray = [bssarray ; BSS*100];
save(['probs_' num2str(ti) '_basin' basin_type '.mat'], 'post_p_log', ...
    'flag_test', 'p_clim_all')
