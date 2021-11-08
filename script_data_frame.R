#linea para correr todo lo del otro archivo ej librerias
source("script_librerias.R")




# actualice R
# install:
rtools 
writeLines('PATH="${RTOOLS40_HOME}\\usr\\bin;${PATH}"', con = "~/.Renviron")

# MCTQ----
## Levantar base de Datos----

getwd()
setwd("C:/Users/Usuario/Desktop/Maestria")
MCTQ<-read.csv2("C:/Users/Usuario/Desktop/Maestria/MCTQ.csv")
View(DF_MCTQ)

## Acomodar la base de datos----

str(MCTQ)
class(MCTQ$SE_W)  #character
                  #como la paso a hora?

MCTQ_horas<- hms(MCTQ)
print()



## Calcular variables----


MCTQ$SLW = MCTQ$SO_W-MCTQ$BT_W  # SLW<- SO_W - BT_W

MCTQ$SDW =MCTQ$SE_W - MCTQ$SO_W # SDW<- SE_W-SO_w

MCTQ$MSW = MCTQ$SO_W+(MCTQ$SDW/2) #MSW<- SO_W+(SDW/2)

MCTQ$SI_IN_W = MCTQ$G_UP_W-MCTQ$SE_W #SI_In_W<- G_UP_W - SE_W


MCTQ$SLF = MCTQ$SO_F-MCTQ$BT_F #SLF<- SO_F - BT_F

MCTQ$SDF =MCTQ$SE_F - MCTQ$SO_F #SDF<- SE_F-SO_F

MCTQ$MSF = MCTQ$SO_F+(MCTQ$SDF/2) #MSF<- SO_F+(SDF/2)

MCTQ$SI_IN_F = MCTQ$G_UP_F-MCTQ$SE_F #SI_In_F<- G_UP_F - SE_F


MCTQ$ASD <-((MCTQ$SDW*5)+(MCTQ$SDF*2))/7 #EN ALGUNOS NINOS SON X6 NO X5 

MCTQ$MSFsc = MCTQ$MSF-((MCTQ$SDF-MCTQ$ASD)/2) #MSFsc<- MSF-((SDF-ASD)/2)  
                                                              #if SDF>SDW, COMO ESCRIBO EL CONDICIONAL?
MCTQ$MSFsc = MCTQ$MSF                         #MSFsc<- MSF ,  #if SDF<= SDW  

MCTQ$SJL = MCTQ$MSF-MCTQ$MSW  #SJL<- MSF-MSW
  
