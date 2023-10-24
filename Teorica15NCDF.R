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
