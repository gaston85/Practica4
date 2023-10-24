require(ncdf4)
nc<-nc_open("hgt850.nc")

hgt850<-ncvar_get(nc,"hgt")
hgt850
longitud<-ncvar_get(nc,"lon")
latitud<-ncvar_get(nc,"lat")
Time<-ncvar_get(nc,"time")


head(Time)
#Datos diarios, en unidad de horas

# UNA forma de poder leer la información de la fecha,
#tengo que saber cuando comienza, el delta t y la cantidad de información

# No es la mas correcta
z<-seq(as.Date("1981/1/1"), by= "day", length.out= 12783)
head(z)

# OTRA forma de leer las fechas es por medio de una libreria que hay que instalar
# libreria para transformar las fechas del ncdf a variable
library(lubridate)
require(lubridate)
#transformo los datos del tiempo
# NOTAR que el "comienzo es 1800-1-1)
time <- ymd_hms ("1800-1-1 00:00:00") + hours(Time)
head(time)


#Otro metodo
fechas<-as.Date(Time/24,origin="1800-01-01")


#Defino las dimensiones de mi variable

dimnames(hgt850)<-list(lon=longitud,lat=latitud,date=as.character(time))


contour(hgt850[,,1])
contour(hgt850[,])
lat20s<-which(latitud==-20)
lat40s<-which(latitud==-40)
contour(hgt850[,lat20s:lat40s,1])
contour(hgt850[,lat40s:lat20s,1])


fecha<-which(format(time,"%Y-%m-%d")=="1996-12-31")
contour(hgt850[,,fecha])


#Ejercicios---------------

rm(list = ls())


nc<-nc_open("olr.mon.mean.nc")

olr<-ncvar_get(nc,"olr")
longitud<-ncvar_get(nc,"lon")
latitud<-ncvar_get(nc,"lat")
Time<-ncvar_get(nc,"time")

library(lubridate)
require(lubridate)

time<-ymd_hms("0001-1-1 00:0.0") + hours(Time)

contour(olr[,,which(format(time,"%Y-%m-%d")=="1996-06-03")])


rm(list = ls())
nc<-nc_open("X157.92.28.55.252.12.27.10.nc")

tsnv<-ncvar_get(nc,"sst")
longitud<-ncvar_get(nc,"lon")
latitud<-ncvar_get(nc,"lat")
Time<-ncvar_get(nc,"time")
time<-ymd_hms("1800-1-1 00:0.0") + days(Time)

plot(tsnv[70,21,],type = "l",col="pink")
