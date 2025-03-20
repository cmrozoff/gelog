function [all_preds, nfeat] = do_not_elim_land_pts(all_preds, missing)
%
% Change missing data to NaN but do not eliminate land data
%
disp(['Changing missing data to NaN, but not eliminating land data.'])
%
%
nfeat = length(all_preds(1, 1, :));
for i = 1:nfeat
    twodim = all_preds(:, :, i);
    ind = find(round(twodim, 1) == missing);
    twodim(ind) = NaN; % Convert -999.9 to NaN
    all_preds(:, :, i) = twodim;
end
%
clear land ind_ocean_nm ind i twodim missing
return
end