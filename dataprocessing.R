librarian::shelf(ggplot2, tidyverse, readxl)

#forage data clean up
getwd()
setwd("C:/Users/lkonrad/OneDrive - Monterey Bay Aquarium Foundation/Desktop")

#call in three tables
dives_tab <- read_xlsx("forage_dives.xlsx")
data_tab <- read_xlsx("forage_data.xlsx")
index_tab <- read_xlsx("forage_index.xlsx")

#Region = "MTRY"
#Area = sub areas 
#Site
#Period
#Date
#Season
#Sex = m, f, u
#AgeClass = j, sa, a, aa, u
#Pup = y, n, u, s, m , l
#Ottername adunk, adfem, admale, subfem, submale, subunk
#Bout
#Subbout

#merge tables
temp <- left_join(dives_tab, data_tab, by = "Foragdiv_ID")
temp <- left_join(temp, index_tab, by = "BOUT")
play <- temp 
play %>% group_by(SEX) %>% count()

#rename existing columns
names(play) <- make.names(names(play), unique=TRUE)
play <- play %>% rename(Site = AREA)
play <- play %>% rename(Sex = SEX)
play <- play %>% rename(AgeClass = AGECLASS)
play <- play %>% rename(Pup = )
play <- play %>% rename(Bout = BOUT)
play <- play %>% rename(Subbout = SUBBOUT)
play <- play %>% rename(Sucess = SUCCESS)
play <- play %>% rename(Prey = PREY)
play <- play %>% rename(N_Items = PREYNUM)
play <- play %>% rename(Size = SIZE)
play <- play %>% rename(Qualifier = QUALIFIER)

#update values to match keys
class(play$N_Items)


plot(play$Date, play$N_items)

#create ottername column
play$Ottername <- play$OTTERNO
play %>% group_by(Prey) %>% count() %>% print(n = 100)

#convert times and date columns
TimeStart = 
  alldata$DATETIME  = as.POSIXct(alldata$DATETIME,format="%m/%d/%Y %H:%M:%S",tz=Sys.timezone())

#pull out a subset for just unknown female to play with smaller dataset
unkfem_subset <- play %>% filter(Ottername == "N-UNFE-16-S")