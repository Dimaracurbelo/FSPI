#linea para correr todo lo del otro archivo ej librerias
source("script_librerias.R")
# actualice R
# install:
rtools 
writeLines('PATH="${RTOOLS40_HOME}\\usr\\bin;${PATH}"', con = "~/.Renviron")

# MCTQ----
## Levantar base de Datos----

getwd()
MCTQ<-read.csv2("MCTQ.csv")
View(DF_MCTQ)
str(MCTQ)
#here para leer nombre de la carpeta y sub carpeta, nombre del archivo

## Buenas practica, Tareas pendientes----
# Crear carpeta cuestionario 
#MCTQ<-read.csv2(here("nombre de la carpeta","MCTQ.csv"))

## Acomodar la base de datos----


# MCTQ <- MCTQ %>% 
#   pivot_longer(cols(c("SE_W", "SE_F")), names_to = c("SE", "tipo_dia"), values_to = "hora", names_pattern = "(.*)_(.*)")

MCTQ <- MCTQ %>% 
  drop_na(Participantes.Participante) %>% 
  # convierto en hms
  mutate(
    SE_W = hm(SE_W),
    SE_F = hm(SE_F),
    SO_W = hm(SO_W),
    SO_F = hm(SO_F),
    ) %>% 
  #calculo la duracion
  mutate(
    SD_W = if_else(SO_W < SE_W, SE_W-SO_W, SE_W-(SO_W-hours(24))),
    SD_F = if_else(SO_F < hms("12:00:00"), SE_F-SO_F, SE_F-(SO_F-hours(24)))
  ) %>% 
  #calculo MS
  mutate(
    MS_W = if_else(SO_W+(SD_W/2) > hours(24), SO_W+(SD_W/2)-hours(24), SO_W+(SD_W/2))
  ) %>% 
  #calculo MSFSc y SJL
  
class(MCTQ$SE_W)  #character
                  #como la paso a hora?

MCTQ_horas<- hms(MCTQ)
print()



## Calcular variables----


MCTQ$SL_W = MCTQ$SO_W-MCTQ$BT_W  # SLW<- SO_W - BT_W

MCTQ$SD_W =MCTQ$SE_W - MCTQ$SO_W # SDW<- SE_W-SO_w

MCTQ$MS_W = MCTQ$SO_W+(MCTQ$SDW/2) #MSW<- SO_W+(SDW/2)

MCTQ$SI_IN_W = MCTQ$G_UP_W-MCTQ$SE_W #SI_In_W<- G_UP_W - SE_W


MCTQ$SL_F = MCTQ$SO_F-MCTQ$BT_F #SLF<- SO_F - BT_F

MCTQ$SD_F =MCTQ$SE_F - MCTQ$SO_F #SDF<- SE_F-SO_F

MCTQ$MS_F = MCTQ$SO_F+(MCTQ$SDF/2) #MSF<- SO_F+(SDF/2)

MCTQ$SI_IN_F = MCTQ$G_UP_F-MCTQ$SE_F #SI_In_F<- G_UP_F - SE_F


MCTQ$ASD <-((MCTQ$SDW*5)+(MCTQ$SDF*2))/7 #EN ALGUNOS NINOS SON X6 NO X5 

MCTQ$MSFsc = MCTQ$MSF-((MCTQ$SDF-MCTQ$ASD)/2) #MSFsc<- MSF-((SDF-ASD)/2)  
                                                              #if SDF>SDW, COMO ESCRIBO EL CONDICIONAL?
MCTQ$MSFsc = MCTQ$MSF                         #MSFsc<- MSF ,  #if SDF<= SDW  

MCTQ$SJL = MCTQ$MSF-MCTQ$MSW  #SJL<- MSF-MSW
  
