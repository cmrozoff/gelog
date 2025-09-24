%
% MPI Calculation
vmax = all_preds(:, :, 48);
vmpi = all_preds(:, :, 49);
cmagt = all_preds(:, :, 37);
sst = all_preds(:, :, 35);
lat = all_preds(:, :, 24);
lon = all_preds(:, :, 25);
%basin = 'EP';
%
rmpi = sst*0.0;
ind = find(sst < 0);
rmpi(ind) = NaN;

% if basin=='AL'
% DeMaria and Kaplan (1994)
vcold = 28.2;
vadd  = 55.8;
a     = 0.1813;
tmax  = 30.0;
%
ind = find(sst >= 0 & strcmp(basin, 'AL'));
rmpi(ind) = vcold + vadd*exp(-a*(tmax-sst(ind)));
rmpi(ind) = rmpi(ind)*1.944;
% elseif basin=='EP'
%East Pacific function (Whitney and Hobgood 1997)
a = -79.2;
b = 5.362;
c = 0.0;
%
tmin = 20.0;

%
ind = find(sst >= 0 & (strcmp(basin, 'EP') | (strcmp(basin, 'CP'))));
sstt = sst;
sstt(ind) = sst(ind);
indtmin = find(sstt < tmin & sstt >= 0);
sstt(indtmin) = tmin;
rmpi(ind) = a + b*sstt(ind) + c;
rmpi(ind) = rmpi(ind)*1.944;
%end
ind165 = find(rmpi > 165.0);
rmpi(ind165) = 165.0;
clear ind165 ind
rmpi_old = rmpi;
%
indboth = find(cmagt > 0 & rmpi > 0);
ind40 = find(cmagt > 40);
cmagt(ind40) = 40.0;
cadj = 0.0 * rmpi;
cadj(indboth) = 1.5 * (cmagt(indboth).^0.63);
rmpi(indboth) = rmpi(indboth) + cadj(indboth);

