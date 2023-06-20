library(oce)
library(ncdf4)

#Locate file
f <- list.files("/Users/cameronrichardson/Desktop/Summer 2023/Work/Glider Project/spring_bloom_2023/mun_slocum/glider_raw/nc FIXED",
                full.names = TRUE)
nc <- nc_open(f[1])

#Find variables
ncNames <- names(nc$var)
ncNames[grep(" ", ncNames)]

lat <- ncvar_get(nc, "lat")
lon <- ncvar_get(nc, "lon")

#Topography
topofile <- download.topo(-72,-50, 40, 54, resolution = 1)
topo <- read.topo(topofile)
imagep(topo, xlim=c(-67,-58),ylim=c(41,50), drawContours = TRUE,
       breaks=c(-1000,-750,-500, -400,-300,-200, -100, -75,-50,-25))
points(lon, lat, col="red",cex=0.7, pch=16)

#Zoomed in topography
ztopofile <- download.topo(-66,-58, 42, 46.5, resolution = 1) #Load topography
ztopo <- read.topo(ztopofile)
imagep(ztopo, xlim=c(-63.7,-62),ylim=c(42.5,45), drawContours = TRUE,
       breaks=c(-1000,-750,-500, -400,-300,-200, -100, -75,-50,-25))
points(lon, lat, col="red",cex=0.7, pch=16)


