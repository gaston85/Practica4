#Es conveniente primero definir las dimensiones del archivo y el código del
#dato faltante en función de los datos del archivo .ctl

nlat <- 181 #cantidad total de la dimension y (o latitudes)
nlon <- 360 #cantidad total de la dimension x (o longitudes)
ntiempos<- 348 #cantidad total de la dimension time (tiempos)
nnivel<- 1 #cantidad total de la dimension z (o niveles)
nvar <- 1 #Cantidad total de variables
dato_faltante<- -999

#Una vez que definí las dimensiones, se que el archivo binario va a tener
#como largo total la multiplicación entre las distintas dimensiones
# N que va a ser longitud del vectorque voy a leer del binario

N<- nlat*nlon*ntiempos*nnivel*nvar

## antes defino la ruta donde esta el archivo
archivo <-"/home/clinux01/gaston/Practica_4/data.r4"
# ahora si abro los datos
datos<- readBin(archivo, "numeric", n = N, endian = "big", size = 4)

datos[which(datos==dato_faltante)]<-NA

# Armo el array teniendo en cuenta que la primer dimension tiene que ser la de las longitudes
# Luego las latitudes y luego el tiempo

datos_array<- array(data = datos, dim = c(nlon, nlat, ntiempos))


#Puedo crear un vector con las longitudes y latitudes, para esto voy a
#necesitar los datos del .ctl:

# ydef 181 linear -90.000000 1.000
# xdef 360 linear 0.000000 1.000000

#Entonces las latitudes, van a ser 181 en total, comienzan en -90° y van cada 1°.

#creo el vector latitudes
latitudes <- seq(-90,90,1)
#chequeo que tenga como longitud 181
length(latitudes)

#Las longitudes seran 360 en total, comienzan en 0° y van cada 1°.
#creo el vector longitudes
longitudes <- seq(0,359,1)
#chequeo que tenga como longitud 181
length(longitudes)

which(latitudes==-55)
which(datos_array[which(longitudes==285):which(longitudes==310),which(latitudes==-55):which(latitudes==-20),]
argentina<-datos_array[which(longitudes==285):which(longitudes==310),which(latitudes==-55):which(latitudes==-20),]
argentina2<-array(argentina,dim = c(26,36,12,29))
arg_prom_anual<-apply(argentina2,c(1,2,4),mean)
dim(arg_prom_anual)
dim(argentina2)


#Ejercicio2

rm(list = ls())

nlat <- 181 #cantidad total de la dimension y (o latitudes)
nlon <- 360 #cantidad total de la dimension x (o longitudes)
ntiempos<- 6 #cantidad total de la dimension time (tiempos)
nnivel<- 1 #cantidad total de la dimension z (o niveles)
nvar <- 4 #Cantidad total de variables
dato_faltante<- 9.999E+20

N<- nlat*nlon*ntiempos*nnivel*nvar


archivo <-"/home/clinux01/gaston/Practica_4/SepIC_nmme_tmpsfc_anom_stdanom.dat"
# ahora si abro los datos
datos<- readBin(archivo, "numeric", n = N, endian = "big", size = 4)

datos[which(datos==dato_faltante)]<-NA

datos_array<- array(data = datos, dim = c(nlon, nlat, nvar,ntiempos))

latitudes <- seq(-90,90,1)
#chequeo que tenga como longitud 181
length(latitudes)

#Las longitudes seran 360 en total, comienzan en 0° y van cada 1°.
#creo el vector longitudes
longitudes <- seq(0,359,1)
#chequeo que tenga como longitud 181
length(longitudes)

argentina_anom_dic<-datos_array[which(longitudes==285):which(longitudes==310),which(latitudes==-55):which(latitudes==-20),3,3]
