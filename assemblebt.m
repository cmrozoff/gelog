%
% Assemble all BT data
%
input_dir = '../besttrack/';
data = dir([input_dir  'b*']);
%
basin_bt = [];
stnum_bt = [];
time_bt = [];
vmax_bt = [];
%
for i = 1:length(data)
    disp(['Working on file ' data(i).name])
    [b, s, t, v] = bt_reader([input_dir data(i).name]);
    basin_bt = [basin_bt ; cellstr(b)];
    stnum_bt = [stnum_bt ; s];
    time_bt = [time_bt ; t];
    vmax_bt = [vmax_bt ; v];
end
%
save('bt_all.mat', 'basin_bt', 'stnum_bt', 'time_bt', 'vmax_bt')
%