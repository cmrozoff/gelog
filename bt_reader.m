%
% Best-track text file reader
%
function [basin_bt, stnum_bt, time_bt, vmax_bt] = bt_reader(file_in)
%
fid = fopen(file_in, 'r');
tline = fgetl(fid);
basin_bt = [];
stnum_bt = [];
time_bt = [];
vmax_bt = [];
%
while ischar(tline)
    if ((str2num(tline(65:66)) == 34 || str2num(tline(65:66)) == 0)) ...
            && (mod(str2num(tline(17:18)), 6) == 0)
        basin_bt = [basin_bt ; tline(1:2)];
        stnum_bt = [stnum_bt ; str2num(tline(5:6))];
        time_bt = [time_bt ; datenum(str2num(tline(9:12)), ...
            str2num(tline(13:14)), str2num(tline(15:16)), ...
            str2num(tline(17:18)), 0, 0)];
        vmax_bt = [vmax_bt ; str2num(tline(49:51))];
    end
    tline = fgetl(fid);
end
%
fclose(fid);
return
end
