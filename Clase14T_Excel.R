##################
##################################################################
# # Laboratorio de Procesamiento de Informaci�n Meteorol�gica
# 1� cuatrimestre 2022
##################################################################
readxl::read_xls(path = xlsfile,)


#readl.xls esta viejo
require(gdata)
xlsfile <- file.path(path.package('gdata'),'xls','iris.xls')
readxl::read_xls(file.path(path.package('gdata'),'xls','iris.xls'))
iris3<-read.xls(file.path(path.package('gdata'),'xls','iris.xls'),method = "csv")
iris2
iris3
class(iris)

exampleFile <- file.path(path.package('gdata'),'xls', 'ExampleExcelFile.xls')
exampleFile2007 <- file.path(path.package('gdata'),'xls', 'ExampleExcelFile.xlsx')
ejemplo1<-read.xls(exampleFile)
sheetCount(exampleFile2007)
sheetNames(exampleFile2007)

data <- read.xls(exampleFile) ## default lee la primer hoja
data1 <- read.xls(exampleFile, sheet=2) ## leo la segunda hoja por numero
data2 <- read.xls(exampleFile, sheet="Sheet Second",v=TRUE) ## leo por nombre

data3 <- read.xls(exampleFile2007, sheet="Sheet with initial text", skip=2)
data4<-readxl::read_xls(exampleFile,sheet =4,skip = 2)


#read.xls(xls, sheet=1, verbose=FALSE, pattern, na.strings =c("NA","#DIV/0!"),...,
#method=c("csv","tsv","tab"), perl="perl")
# cuando no me deja cargar una libreria poner:
options(repos ='http://cran.rstudio.com') 

##################################################
rm(list = ls())
#############################
## EJEMPLO

meteo<-file.path('datos.xls')
sheetCount(meteo)
sheetCount("datos.xls") 

sheetNames("datos.xls")
#readxl::excel_sheets(meteo)

meteo_0<-read.xls(meteo,sheet=2)
meteo_1<-read.xls("datos.xls",sheet = 2)

head(meteo_1)
class(meteo_1)
correlacion<-cor(meteo_1[,1],meteo_1[,2]) 

meteo_2<-read.xls(meteo,sheet = 3,skip=1)
colnames(meteo_2)<-c("año","mes","Tmax","Tmin","pp")
head(meteo_2)
class(meteo_2)
plot(meteo_2[,3],type="l")
plot(meteo_2[1:12,5],type="h")

medias<-apply(meteo_2[,3:5],2,mean)

medias_onda<-matrix(0,nrow=12,ncol=3)
for (i in 1:12){
  a=which(meteo_2[,2]==i)
  medias_onda[i,1:3]<-apply(meteo_2[a,3:5],2,mean)
}

plot(medias_onda[,1],type="l",col='red',ylim=c(0,30))
lines(medias_onda[,2],type="l",col='blue')
plot(meteo_1[,1],type="l",col='red',ylim=c(20,30))
lines(meteo_1[,2],col="blue")

############### Imagenes raster #################

require("raster") #para trabajar con la imagen
require("maps") #para el grafico

WIND<-rasterI("/home/clinux01/gaston/Practica_4/wind_speed_monthly_globe_2014.grib",
             band=2) ## elijo una banda
plot(WIND)

WIND2014<-brick("/home/clinux01/gaston/Practica_4/wind_speed_monthly_globe_2014.grib",
             band=2)
