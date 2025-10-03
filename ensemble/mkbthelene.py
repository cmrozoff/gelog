import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.colors as mcolors
from matplotlib.colors import ListedColormap, BoundaryNorm
import matplotlib.cm as cm
import cartopy.crs as ccrs
import cartopy.feature as cf
from cartopy.io.shapereader import natural_earth
from matplotlib.cm import ScalarMappable
import matplotlib.ticker as mticker

# Load file
file_path = "bal092024.dat"

max_lat = 38
min_lat = 12 # 17 for 2,3, 16 for 1
min_lon = -100
max_lon = -70

with open(file_path, 'r') as file:
    lines = file.readlines()

# Manually parse the file
parsed_rows = []
for line in lines:
    parts = line.strip().split(',')
    if len(parts) >= 9:
        datetime = parts[2].strip()
        lat = parts[6].strip()
        lon = parts[7].strip()
        wind = parts[8].strip()
        parsed_rows.append((datetime, lat, lon, wind))

# Create DataFrame
df = pd.DataFrame(parsed_rows, columns=['datetime', 'latitude', 'longitude', 'wind_speed'])

# Clean and convert
df['latitude'] = df['latitude'].str.rstrip('N').astype(float) / 10.0
df['longitude'] = -df['longitude'].str.rstrip('W').astype(float) / 10.0
df['wind_speed'] = pd.to_numeric(df['wind_speed'], errors='coerce')

# Drop duplicates and missing values
df = df.drop_duplicates().dropna().reset_index(drop=True)

# Define Saffir-Simpson wind scale bins and colors
wind_bins = [0, 34, 65, 84, 96, 114, 135, 200]  # 200 instead of inf
wind_colors = [
    'forestgreen',  # 0-33
    'beige',   # 34-64
    'yellow',       # 65-83
    'orange',       # 84-95
    'orangered',   # 96-113
    'darkred',   # 114-134
    'darkviolet'       # 135+
]
cmap = ListedColormap(wind_colors)
norm = BoundaryNorm(wind_bins, cmap.N)
# Display labels for the colorbar
display_labels = [
    "", "TS", "Cat 1", "Cat 2",
    "Cat 3", "Cat 4", "Cat 5"
]

# Plot setup
projection = ccrs.Mercator()
crs = ccrs.PlateCarree()
plt.figure(figsize=(26, 6), dpi = 300)
ax = plt.axes(projection = projection, frameon = True)
gl = ax.gridlines(crs = crs, draw_labels = True, linewidth = 0.6,
                color = 'gray', alpha = 0.5, linestyle = '-.')
gl.top_labels = False
gl.right_labels = False
gl.xlabel_style = {"size" : 14}
gl.ylabel_style = {"size" : 14}

# Add map features
ax.add_feature(cf.COASTLINE.with_scale("50m"), lw=0.5)
ax.add_feature(cf.BORDERS.with_scale("50m"), lw=0.3)
ax.add_feature(cf.LAKES, alpha = 0.5)
ax.add_feature(cf.LAND, facecolor="silver")
# Add state boundaries
states_provinces = cf.NaturalEarthFeature(
    category='cultural',
    name='admin_1_states_provinces_lines',
    scale='10m',
    facecolor='none')
ax.add_feature(states_provinces, edgecolor='black', lw=0.3, alpha=0.2)
ax.add_feature(cf.OCEAN, facecolor="lightblue")

ax.set_extent([min_lon, max_lon, min_lat, max_lat ])

# Draw colored lines between points
for i in range(len(df) - 1):
    lat1, lon1 = df.loc[i, ['latitude', 'longitude']]
    lat2, lon2 = df.loc[i + 1, ['latitude', 'longitude']]
    wind = df.loc[i, 'wind_speed']
    color = cmap(norm(wind))
    ax.plot([lon1, lon2], [lat1, lat2], color=color, alpha = 0.75, linewidth=2, transform=ccrs.PlateCarree())

# Scatter plot
sc = ax.scatter(df['longitude'], df['latitude'], c=df['wind_speed'], 
                cmap=cmap, norm=norm, alpha = 0.8, s=15, zorder=3, transform=ccrs.PlateCarree())
# Colorbar setup
cbar = plt.colorbar(sc, ax=ax, ticks=wind_bins[:-1])
cbar.set_label('Saffir-Simpson Scale')
cbar.ax.set_yticklabels(display_labels)
cbar.ax.tick_params(labelsize=14)

plt.savefig('plot.png', bbox_inches = 'tight')
plt.show()

