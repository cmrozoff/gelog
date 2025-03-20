import numpy as np
import matplotlib.pyplot as plt
import cartopy.crs as ccrs
import cartopy.feature as cfeature
from netCDF4 import Dataset
from sys import exit

# Load NetCDF file
nc_file = "prediction_AL09_2024092500.nc"  # Change to the actual filename
ds = Dataset(nc_file, mode="r")

# Extract variables
prob_f = ds.variables["prob_f"][:]         # Shape (NM, NT)
reduced_f = ds.variables["reduced_f"][:]   # Shape (NM, NF, NT)
vmaxbt_f = ds.variables["vmaxbt_f"][:]     # Shape (NT)

NM, NF, NT = reduced_f.shape  # Extract dimensions
#
lon_idx = 24;
lat_idx = 23;

# Assume longitude and latitude are feature indices
longitude = reduced_f[:, lon_idx, :]  # Shape (NM, NT)
latitude = reduced_f[:, lat_idx, :]   # Shape (NM, NT)

print(longitude[0,:]-360)
exit()

# Create the plot
fig, ax = plt.subplots(figsize=(10, 6), subplot_kw={"projection": ccrs.PlateCarree()})

# Add map features
ax.add_feature(cfeature.LAND, edgecolor="black")
ax.add_feature(cfeature.BORDERS, linestyle=":")
ax.add_feature(cfeature.STATES, linestyle=":", edgecolor="gray")
ax.add_feature(cfeature.COASTLINE)
ax.add_feature(cfeature.OCEAN, facecolor="lightblue")

# Plot trajectories with prob_f as color
for i in range(NM):
    sc = ax.scatter(longitude[i, :], latitude[i, :], c=prob_f[i, :], cmap="viridis", 
                     vmin=0, vmax=1, s=10, edgecolors="k", transform=ccrs.PlateCarree())

# Add colorbar
cbar = plt.colorbar(sc, ax=ax, orientation="vertical", label="Probability (prob_f)")

# Labels and title
ax.set_title("Forecast Ensemble Trajectories with Probability Color Coding")
ax.set_xlabel("Longitude")
ax.set_ylabel("Latitude")

plt.show()

# Close dataset
ds.close()
