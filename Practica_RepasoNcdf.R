require(ncdf4)

nc<-nc_open("/home/clinux01/gaston/Practica_4/air.mon.mean.nc")

temp_aire<-ncvar_get(nc,"air")
long<-ncvar_get(nc,"lon")
time<-ncvar_get(nc,"time")
lat<-ncvar_get(nc,"lat")


tiempos_legibles<-as.Date(time/24,origin="1800-01-01")
head(tiempos_legibles)

require(lubridate)

head(months(tiempos_legibles))

datos_temp_marzo <- temp_aire[, ,months(tiempos_legibles) == "marzo"]
dim(datos_temp_marzo)



library(udunits2)
library(metR)
library(PCICt)
archivo<-
GlanceNetCDF("/home/clinux01/gaston/Practica_4/air.mon.mean.nc")


datos <- ReadNetCDF("/home/clinux01/gaston/Practica_4/air.mon.mean.nc", vars = "air") #abro los datos
head(datos) #miro las primeras filas


datos_region<- ReadNetCDF(archivo, vars = "air",
                          subset = list(lat = c(-65, -20),
                                        lon = c(280, 310)))



rm(list = ls())
library(lubridate)
archivo="/home/clinux01/gaston/Practica_4/datos_u850.nc"
GlanceNetCDF(archivo)

datos_region<- ReadNetCDF(archivo,vars = "ua850")
datos_delta<-ReadNetCDF(archivo,vars = "ua850",subset = list(lat=c(-38.75,-23.75),lon=c(-64.25,-51.25)))
year(datos_delta$time)

promedio_cuenca<-c()
for (i in 0:5) {
  promedio_cuenca[i+1]<-mean(datos_delta$ua850[year(datos_delta$time)==(2005+i)],na.rm = T)
}

datos_cuenca<-data.frame("Anio"=seq(2005,2010),"Datos_u"=promedio_cuenca)
