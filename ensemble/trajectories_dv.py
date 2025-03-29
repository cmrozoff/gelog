import numpy as np
import matplotlib.pyplot as plt
import cartopy.crs as ccrs
import cartopy.feature as cfeature
from cartopy.io.shapereader import natural_earth
from matplotlib.cm import ScalarMappable
import matplotlib.ticker as mticker
from netCDF4 import Dataset
import matplotlib.colors as mcolors
import matplotlib.cm as cm
from matplotlib import colormaps
from sys import exit

# Load NetCDF file
stnam = 'AL14' #'AL09'
yr = '2024'
mo = '10' #'09'
da = '06' #'26'
hr = '06'
#
#
# Helene
max_lat = 29
min_lat = 16 # 17 for 2,3, 16 for 1
min_lon = -92
max_lon = -75
#
# Milton
max_lat = 28
min_lat = 15
min_lon = -96
max_lon = -71
#
nc_file = ("predictions/prediction_" + stnam + "_" + yr + mo + da + hr + ".nc")
file_out = ("dv_" + stnam + "_" + yr + mo + da + hr + ".png")
#
ds = Dataset(nc_file, mode="r")
#
dir_native = '/glade/work/rozoff/ensri/ENCORE/data_output/2024/'
#
# Extract variables
prob_f = ds.variables["prob_f"][:]         # Shape (NM, NT)
reduced_f = ds.variables["reduced_f"][:]   # Shape (NM, NF, NT)
vmaxbt_f = ds.variables["vmaxbt_f"][:]     # Shape (NT)

var_f = np.squeeze(reduced_f[:, 53, :])

NM, NF, NT = reduced_f.shape  # Extract dimensions
#
lon_idx = 24;
lat_idx = 23;

# Assume longitude and latitude are feature indices
longitude = reduced_f[:, lon_idx, :] - 360  # Shape (NM, NT)
latitude = reduced_f[:, lat_idx, :]   # Shape (NM, NT)

meanlon = np.nanmean(longitude)
meanlat = np.nanmean(latitude)

#max_lat = meanlat + 10
#min_lat = meanlat - 10
#max_lon = meanlon - 15
#min_lon = meanlon + 15

#
print('Plotting field')
projection = ccrs.Mercator()
crs = ccrs.PlateCarree()
plt.figure(dpi = 150)
ax = plt.axes(projection = projection, frameon = True)
gl = ax.gridlines(crs = crs, draw_labels = True, linewidth = 0.6,
                color = 'gray', alpha = 0.5, linestyle = '-.')
gl.top_labels = False
gl.right_labels = False
gl.xlabel_style = {"size" : 10}
gl.ylabel_style = {"size" : 10}
import cartopy.feature as cf

# Add map features
ax.add_feature(cf.COASTLINE.with_scale("50m"), lw=0.5)
ax.add_feature(cf.BORDERS.with_scale("50m"), lw=0.3)
ax.add_feature(cf.LAKES, alpha = 0.5)
ax.add_feature(cfeature.LAND, facecolor="silver")
# Add state boundaries
states_provinces = cfeature.NaturalEarthFeature(
    category='cultural',
    name='admin_1_states_provinces_lines',
    scale='10m',
    facecolor='none')
ax.add_feature(states_provinces, edgecolor='black', lw=0.3, alpha=0.2)
ax.add_feature(cfeature.OCEAN, facecolor="lightblue")

ax.set_extent([min_lon, max_lon, min_lat, max_lat ])


# Create colormap
#cmap = cm.get_cmap("viridis")

cmap = colormaps.get_cmap("gist_ncar_r")
norm = mcolors.Normalize(vmin=-40, vmax=40)


# Step 1: Compute max probability for each trajectory
max_var = np.max(prob_f, axis=1)  # Shape: (NM,)

# Step 2: Get sorted indices based on max probability
sorted_indices = np.argsort(max_var)  # Smallest to largest

# Plot trajectories as lines
for idx in sorted_indices:
    for t in range(NT - 1):  # Iterate over time steps
        color = cmap(norm(var_f[idx, t]))  # Color based on prob_f
        ax.plot([longitude[idx, t], longitude[idx, t+1]], 
                [latitude[idx, t], latitude[idx, t+1]], 
                color=color, linewidth=1.5, transform=ccrs.PlateCarree())

# Create colorbar
sm = plt.cm.ScalarMappable(cmap=cmap, norm=norm)
cbar = plt.colorbar(sm, ax=ax, orientation="vertical", label="Probability (prob_f)")

# Labels and title
ax.set_xlabel("Longitude")
ax.set_ylabel("Latitude")

plt.savefig(file_out, bbox_inches = 'tight')

plt.show()

# Close dataset
ds.close()
