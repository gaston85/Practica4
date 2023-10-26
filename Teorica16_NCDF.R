#################
##################################################################
# # Laboratorio de Procesamiento de Informaci�n Meteorol�gica/Oceanografica

# 2� cuatrimestre 2022
##################################################################

##################################################
#######################################
# clase NCDF 2
####################
##################################################################


require(ncdf4)
require(lubridate)

OUTPUTS<- ("/home/clinux01/Documentos/GastonLabo/Practica_4/")

lon <- seq(270,320,5)
lats<-seq(-10,-50,-5)

length(lon)
length(lats)

Months<-as.numeric(seq(as.Date("1979/1/1"), by= "month", length.out= 432))

Months

#Definicion de las dimensiones

dimX<- ncdim_def( "long", "degrees", lon)
dimY<- ncdim_def ( "lat", "degrees", lats )
dimT<- ncdim_def( "Time", "days", Months, unlim=TRUE )

#Definicion de la variable
var1d <- ncvar_def("mslp", units= "hPa", longname= "mean sea level pressure",
                   dim= list(dimX,dimY,dimT), missval= -999, prec="double",verbose=TRUE )

#Creo el archivo donde se van a guardar las cosas
nc<- nc_create(paste(OUTPUTS,"mslp_hPa.nc",sep=""), list(var1d) )

#Creo la variable
MSLP<-runif(42768)

#Pongo las cosas en la caja
ncvar_put( nc, var1d, MSLP )

nc_close(nc)

###########################

#### ABRIR lo que guardamos

nc<-nc_open("/home/clinux01/Documentos/GastonLabo/Practica_4/mslp_hPa.nc")
nc
class(nc)


presion<-ncvar_get(nc,varid="mslp") 

Longitud<-ncvar_get(nc,varid="long")
Latitud<-ncvar_get(nc,varid="lat")
Time<-ncvar_get(nc,varid="Time")

class(presion)
class(Longitud)
class(Latitud)

class(Time)

head(Time)

fecha<-ymd_hms ("1970-1-1 00:00:00") + days(Time) #Falta cargar un atributo a la fecha, que es desde donde inicializa.

head(fecha)
tail(fecha)


presion[2,2,3]


#Ejercicio
rm(list = ls())
nc<-nc_open("X157.92.28.55.252.12.27.10.nc")
nc

sst<-ncvar_get(nc,varid="sst") 
Longitud<-ncvar_get(nc,varid="lon")
Latitud<-ncvar_get(nc,varid="lat")
Time<-ncvar_get(nc,varid="time")

time<-ymd_hms("1800-1-1 00:0.0") + days(Time)
fecha1<-which(format(time,"%Y-%m-%d")=="1990-01-01")
fecha2<-which(format(time,"%Y-%m-%d")=="1999-12-01")

sst_cortada<-sst[,,fecha1:fecha2]

#Se hace lo que hiciste al principio

OUTPUTS<-("/home/clinux01/Documentos/GastonLabo/Practica_4/")

