#Formato Ascii

#readtable:Esta función lee un archivo con formato de tabla y crea un data frame

archivo<-"/home/clinux01/gaston/Practica_4/boya.txt"
datos<-read.table(archivo,col.names = c("anio","Mes","TSM"),header = T)

datos_2<-read.table("boya_2.txt")
datos_2<-read.table("boya_2.txt",sep = ",")

datos_2<- scan("boya_2.txt",what = list("numeric(0)","numeric","numeric"),sep = ",")

# Creo dos vectores
tipo <- c("A", "B", "C")
longitud <- c(120.34, 99.45, 115.67)
## Con los vectores tipo longitud creo un data frame
datos_salida <- data.frame(tipo, longitud)
datos_salida


#Ejemplo
rm(list = ls())
datos_estaciones<-read.table("datos_estaciones.txt",header = T,na.strings = -999)

sum(is.na(datos_estaciones))

maxT<-max(datos_estaciones$TEMP,na.rm = T)  
maxH<-max(datos_estaciones$HUM,na.rm = T)  
maxP<-max(datos_estaciones$PNM,na.rm = T)  

estacion_MaxT<-as.character(datos_estaciones$NOMBRE[which(datos_estaciones$TEMP==maxT)])
estacion_MaxH<-as.character(datos_estaciones$NOMBRE[which(datos_estaciones$HUM==maxH)])
estacion_MaxP<-as.character(datos_estaciones$NOMBRE[which(datos_estaciones$PNM==maxP)])

hora_MaxT<-datos_estaciones$HORA[which(datos_estaciones$TEMP==maxT)]
hora_MaxH<-datos_estaciones$HORA[which(datos_estaciones$HUM==maxH)]
hora_MaxP<-datos_estaciones$HORA[which(datos_estaciones$PNM==maxP)]


media_estaciones<-c()
desvio_estaciones<-c()
j<-1
for (i in levels(datos_estaciones$NOMBRE)) {
  if(i=="AEROPARQUE"|i=="RESISTENCIA"|i=="TUCUMAN"|i=="VIEDMA"){
    media_estaciones[j]<-mean(datos_estaciones$TEMP[datos_estaciones$NOMBRE==i],na.rm =T)
    desvio_estaciones[j]<-sd(datos_estaciones$TEMP[datos_estaciones$NOMBRE==i],na.rm =T)
    j<-j+1
  }
}

data_estaciones<-data.frame(media_estaciones,desvio_estaciones,
                            row.names = c("Aeroparque","Resistencia","Tucuman","Viedma"))
data_estaciones<-round(data_estaciones,digits = 2)
colnames(data_estaciones)<-c("Media","Desvio_Estandar")
write.table(data_estaciones,file = "data_estaciones.txt",quote = F,sep =" ",
            row.names = T,col.names = T)
