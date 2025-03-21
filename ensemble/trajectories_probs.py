import numpy as np
import matplotlib.pyplot as plt
import cartopy.crs as ccrs
import cartopy.feature as cfeature
from netCDF4 import Dataset
import matplotlib.colors as mcolors
import matplotlib.cm as cm
from sys import exit

# Load NetCDF file
nc_file = "predictions/prediction_AL09_2024092500.nc"  # Change to the actual filename
ds = Dataset(nc_file, mode="r")

dir_native = '/glade/work/rozoff/ensri/ENCORE/data_output/2024/'

# Extract variables
prob_f = ds.variables["prob_f"][:]         # Shape (NM, NT)
reduced_f = ds.variables["reduced_f"][:]   # Shape (NM, NF, NT)
vmaxbt_f = ds.variables["vmaxbt_f"][:]     # Shape (NT)

NM, NF, NT = reduced_f.shape  # Extract dimensions
#
lon_idx = 24;
lat_idx = 23;

# Assume longitude and latitude are feature indices
longitude = reduced_f[:, lon_idx, :] - 360  # Shape (NM, NT)
latitude = reduced_f[:, lat_idx, :]   # Shape (NM, NT)


# Create the plot
fig, ax = plt.subplots(figsize=(10, 6), subplot_kw={"projection": ccrs.PlateCarree()})

# Add map features
ax.add_feature(cfeature.LAND, edgecolor="black")
ax.add_feature(cfeature.BORDERS, linestyle=":")
ax.add_feature(cfeature.STATES, linestyle=":", edgecolor="gray")
ax.add_feature(cfeature.COASTLINE)
ax.add_feature(cfeature.OCEAN, facecolor="lightblue")


# Create colormap
#cmap = cm.get_cmap("viridis")
cmap = cm.get_cmap("gist_ncar_r")
norm = mcolors.Normalize(vmin=0, vmax=1)

# Plot trajectories as lines
for i in range(NM):
    for t in range(NT - 1):  # Iterate over time steps
        color = cmap(norm(prob_f[i, t]))  # Color based on prob_f
        ax.plot([longitude[i, t], longitude[i, t+1]], 
                [latitude[i, t], latitude[i, t+1]], 
                color=color, linewidth=1.5, transform=ccrs.PlateCarree())

# Create colorbar
sm = plt.cm.ScalarMappable(cmap=cmap, norm=norm)
cbar = plt.colorbar(sm, ax=ax, orientation="vertical", label="Probability (prob_f)")

# Labels and title
ax.set_title("Forecast Ensemble Trajectories with Probability Color Coding")
ax.set_xlabel("Longitude")
ax.set_ylabel("Latitude")

plt.show()

# Close dataset
ds.close()
