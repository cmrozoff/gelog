function [ind_ri, dvmax_bt, dvmax_model, nlt] = ...
    define_ri(time_inc, all_preds, vmax_bt, ri_defn)
%
% This program parses out forecasts in which RI was observed, according to
%  best track data. It also obtains indices to keep track of points in data
%  where these events occur.
%
%disp('Identifying times in which RI occurred.')
%
nlt = time_inc / 6.0; % GEFS forecasts are output at 6-hour lead-times
%
vmax_model = all_preds(:, :, 48);
%
[ncases, ntimes] = size(vmax_model);
ind_ri = NaN(ncases, ntimes - nlt);
dvmax_bt = NaN(ncases, ntimes - nlt);
dvmax_model = NaN(ncases, ntimes - nlt);
%
for i = 1:(ntimes - nlt)
    %
    ind = find(~isnan(vmax_bt(:, i)) & ~isnan(vmax_bt(:, i + nlt)));
    dvmax_bt(ind, i) = vmax_bt(ind, i + nlt) - vmax_bt(ind, i);
    ind = find(~isnan(vmax_model(:, i)) & ~isnan(vmax_model(:, i + nlt)));
    dvmax_model(ind, i) = vmax_model(ind, i + nlt) - vmax_model(ind, i);
    ind = find(dvmax_bt(:, i) >= ri_defn);
    ind_ri(ind, i) = 1.0;
    ind = find(dvmax_bt(:, i) < ri_defn);
    ind_ri(ind, i) = 0.0;
end
%
clear ind i
return
end