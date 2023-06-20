library(oce)
library(ncdf4)

#Locate file
f <-
  list.files(
    "/Users/cameronrichardson/Desktop/Summer 2023/Work/Glider Project/spring_bloom_2023/mun_slocum/glider_raw/nc FIXED",
    full.names = TRUE
  )
nc <- nc_open(f[1])

#Find variables
ncNames <- names(nc$var)
ncNames[grep("depth", ncNames)]

lat <- ncvar_get(nc, "lat")
lon <- ncvar_get(nc, "glider_record/m_gps_lon")
O2 <- ncvar_get(nc, "oxygen_concentration")
P <- ncvar_get(nc, "pressure")
t <- ncvar_get(nc, "time")

#Subset
ok <- is.finite(O2) & is.finite(P) & is.finite(t) & is.finite(lon)

#Colormap
O2cm <- colormap(O2[ok], col = oceColorsTurbo)
drawPalette(
  colormap = O2cm,
  zlab = paste0(
    "Oxygen Concentration",
    " ",
    "[",
    nc$var$oxygen_concentration$units,
    "]"
  )
)
oce.plot.ts(
  t[ok],
  P[ok],
  flipy = TRUE,
  mar = c(3, 3, 3, 6),
  col = O2cm$zcol,
  type = "p",
  pch = 20,
  cex = 1
)

#Focus on an area of interest
focus <- locator(n=2)
