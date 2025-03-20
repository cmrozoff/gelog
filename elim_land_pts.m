function [all_preds, nfeat] = elim_land_pts(all_preds, missing)
%
% Eliminate land points
%
%disp(['Determining which data are over land. Setting to missing.'])
%
land = all_preds(:, :, 23);
%
ind_ocean_nm = find(land < 0);
land(ind_ocean_nm) = NaN;
%
nfeat = length(all_preds(1, 1, :));
for i = 1:nfeat
    twodim = all_preds(:, :, i);
    ind = find(round(twodim, 1) == missing);
    twodim(ind) = NaN; % Convert -999.9 to NaN
    twodim(ind_ocean_nm) = NaN;
    all_preds(:, :, i) = twodim;
end
%
clear land ind_ocean_nm ind i twodim missing
return
end
