#This is an r-script written to run with R

#Katelyn Baker, University of Colorado Anschutz - Laboratory of Dr. Kimberley Bruce
#2025

#Purpose: combine FIJI output data and exclude cells/regions-of-interests with no DAPI signal

#Image analysis - combining the 3 channels of 3 viewpoints into one .csv file
#Updated 11.27.2024

#Set up-----------
setwd("") #where FIJI output is located

install.packages("dplyr")
install.packages("tidyr")
library("dplyr")
library("tidyr")

getwd()
list.files("") #list files from the wd


#Set up objects for the separate data files (DAPI, phalloidin, POPC)
dapis <- lapply(list.files("location", pattern = "_dapi.csv"), read.csv) #dapis object will include all files from the FIJI output with the _dapi.csv ending -> all .csvs for DAPI data
phalloidins <- lapply(list.files("location", pattern = "phalloidin_morphology.csv"), read.csv) #phalloidins object will include all files from the FIJI output with the phalloidin_morphology.csv ending -> all .csvs for phalloidin data
popcs <- lapply(list.files("location", pattern = "_popc.csv"), read.csv) #popcs object will include all files from the FIJI output with the _popc.csv ending -> all .csvs for popc data


#The following steps are re-organizing the .csv datasets and creating a data-frame for each well picture. Then, it combines each well image to create one large dataframe per well. Then, it removes lines (each line represents a cell/region of interest) that's negative for DAPI (Maximum = 0). Finally, it outputs this filtered data-frame as a single .csv file per well.


#A2
{i <-1
  Well_pic1 <- data.frame(Well_image_num = dapis[[i]]$Label,
                          Mask_number = dapis[[i]]$X, 
                          DAPI_max = dapis[[i]]$Max, 
                          Area = phalloidins[[i]]$Area, 
                          Circularity = phalloidins[[i]]$Circ.,
                          AR = phalloidins[[i]]$AR, 
                          Roundness = phalloidins[[i]]$Round,
                          Solidity = phalloidins[[i]]$Solidity,
                          Phal_mean = phalloidins[[i]]$Mean,
                          Phal_min = phalloidins[[i]]$Min,
                          Phal_max = phalloidins[[i]]$Max,
                          Phal_int_den = phalloidins[[i]]$IntDen,
                          Phal_raw_int_den = phalloidins[[i]]$RawIntDen,
                          POPC_mean = popcs[[i]]$Mean,
                          POPC_min = popcs[[i]]$Min,
                          POPC_max = popcs[[i]]$Max,
                          POPC_int_den = popcs[[i]]$IntDen,
                          POPC_raw_int_den = popcs[[i]]$RawIntDen)
  Well_pic2 <- data.frame(Well_image_num = dapis[[i+1]]$Label,
                          Mask_number = dapis[[i+1]]$X, 
                          DAPI_max = dapis[[i+1]]$Max, 
                          Area = phalloidins[[i+1]]$Area, 
                          Circularity = phalloidins[[i+1]]$Circ.,
                          AR = phalloidins[[i+1]]$AR, 
                          Roundness = phalloidins[[i+1]]$Round,
                          Solidity = phalloidins[[i+1]]$Solidity,
                          Phal_mean = phalloidins[[i+1]]$Mean,
                          Phal_min = phalloidins[[i+1]]$Min,
                          Phal_max = phalloidins[[i+1]]$Max,
                          Phal_int_den = phalloidins[[i+1]]$IntDen,
                          Phal_raw_int_den = phalloidins[[i+1]]$RawIntDen,
                          POPC_mean = popcs[[i+1]]$Mean,
                          POPC_min = popcs[[i+1]]$Min,
                          POPC_max = popcs[[i+1]]$Max,
                          POPC_int_den = popcs[[i+1]]$IntDen,
                          POPC_raw_int_den = popcs[[i+1]]$RawIntDen)
  total_well <- rbind(Well_pic1, Well_pic2) #combine all 3 pics from the same well together
  total_well <- total_well[total_well$DAPI_max > 0,] #Take out DAPI- cells
  total_well <- subset(total_well, select = -DAPI_max) #Dont want the DAPI column 
write.csv(total_well,file = "(output location)/(name file).csv" )}
#A3
{i <-3 #change this number depending on how many pictures were in the first well. mine had 2 pictures for the well "A2", so the first document of the next well, "A3" will be the third in the directory list.
Well_pic1 <- data.frame(Well_image_num = dapis[[i]]$Label,
                        Mask_number = dapis[[i]]$X, 
                        DAPI_max = dapis[[i]]$Max, 
                        Area = phalloidins[[i]]$Area, 
                        Circularity = phalloidins[[i]]$Circ.,
                        AR = phalloidins[[i]]$AR, 
                        Roundness = phalloidins[[i]]$Round,
                        Solidity = phalloidins[[i]]$Solidity,
                        Phal_mean = phalloidins[[i]]$Mean,
                        Phal_min = phalloidins[[i]]$Min,
                        Phal_max = phalloidins[[i]]$Max,
                        Phal_int_den = phalloidins[[i]]$IntDen,
                        Phal_raw_int_den = phalloidins[[i]]$RawIntDen,
                        POPC_mean = popcs[[i]]$Mean,
                        POPC_min = popcs[[i]]$Min,
                        POPC_max = popcs[[i]]$Max,
                        POPC_int_den = popcs[[i]]$IntDen,
                        POPC_raw_int_den = popcs[[i]]$RawIntDen)
Well_pic2 <- data.frame(Well_image_num = dapis[[i+1]]$Label,
                        Mask_number = dapis[[i+1]]$X, 
                        DAPI_max = dapis[[i+1]]$Max, 
                        Area = phalloidins[[i+1]]$Area, 
                        Circularity = phalloidins[[i+1]]$Circ.,
                        AR = phalloidins[[i+1]]$AR, 
                        Roundness = phalloidins[[i+1]]$Round,
                        Solidity = phalloidins[[i+1]]$Solidity,
                        Phal_mean = phalloidins[[i+1]]$Mean,
                        Phal_min = phalloidins[[i+1]]$Min,
                        Phal_max = phalloidins[[i+1]]$Max,
                        Phal_int_den = phalloidins[[i+1]]$IntDen,
                        Phal_raw_int_den = phalloidins[[i+1]]$RawIntDen,
                        POPC_mean = popcs[[i+1]]$Mean,
                        POPC_min = popcs[[i+1]]$Min,
                        POPC_max = popcs[[i+1]]$Max,
                        POPC_int_den = popcs[[i+1]]$IntDen,
                        POPC_raw_int_den = popcs[[i+1]]$RawIntDen)
total_well <- rbind(Well_pic1, Well_pic2) #combine all 3 pics from the same well together
total_well <- total_well[total_well$DAPI_max > 0,] #Take out DAPI- cells
total_well <- subset(total_well, select = -DAPI_max) #Dont want the DAPI column 
write.csv(total_well,file = "(output location)/(name file).csv" )
}
#B2
{i <-5
  Well_pic1 <- data.frame(Well_image_num = dapis[[i]]$Label,
                          Mask_number = dapis[[i]]$X, 
                          DAPI_max = dapis[[i]]$Max, 
                          Area = phalloidins[[i]]$Area, 
                          Circularity = phalloidins[[i]]$Circ.,
                          AR = phalloidins[[i]]$AR, 
                          Roundness = phalloidins[[i]]$Round,
                          Solidity = phalloidins[[i]]$Solidity,
                          Phal_mean = phalloidins[[i]]$Mean,
                          Phal_min = phalloidins[[i]]$Min,
                          Phal_max = phalloidins[[i]]$Max,
                          Phal_int_den = phalloidins[[i]]$IntDen,
                          Phal_raw_int_den = phalloidins[[i]]$RawIntDen,
                          POPC_mean = popcs[[i]]$Mean,
                          POPC_min = popcs[[i]]$Min,
                          POPC_max = popcs[[i]]$Max,
                          POPC_int_den = popcs[[i]]$IntDen,
                          POPC_raw_int_den = popcs[[i]]$RawIntDen)
  Well_pic1 <- Well_pic1[Well_pic1$DAPI_max > 0,] #Take out DAPI- cells
  total_well <- subset(Well_pic1, select = -DAPI_max) #Dont want the DAPI column 
  write.csv(total_well,file = "(output location)/(name file).csv" )
}
#B3
{i <-6
  Well_pic1 <- data.frame(Well_image_num = dapis[[i]]$Label,
                          Mask_number = dapis[[i]]$X, 
                          DAPI_max = dapis[[i]]$Max, 
                          Area = phalloidins[[i]]$Area, 
                          Circularity = phalloidins[[i]]$Circ.,
                          AR = phalloidins[[i]]$AR, 
                          Roundness = phalloidins[[i]]$Round,
                          Solidity = phalloidins[[i]]$Solidity,
                          Phal_mean = phalloidins[[i]]$Mean,
                          Phal_min = phalloidins[[i]]$Min,
                          Phal_max = phalloidins[[i]]$Max,
                          Phal_int_den = phalloidins[[i]]$IntDen,
                          Phal_raw_int_den = phalloidins[[i]]$RawIntDen,
                          POPC_mean = popcs[[i]]$Mean,
                          POPC_min = popcs[[i]]$Min,
                          POPC_max = popcs[[i]]$Max,
                          POPC_int_den = popcs[[i]]$IntDen,
                          POPC_raw_int_den = popcs[[i]]$RawIntDen)
  Well_pic2 <- data.frame(Well_image_num = dapis[[i+1]]$Label,
                          Mask_number = dapis[[i+1]]$X, 
                          DAPI_max = dapis[[i+1]]$Max, 
                          Area = phalloidins[[i+1]]$Area, 
                          Circularity = phalloidins[[i+1]]$Circ.,
                          AR = phalloidins[[i+1]]$AR, 
                          Roundness = phalloidins[[i+1]]$Round,
                          Solidity = phalloidins[[i+1]]$Solidity,
                          Phal_mean = phalloidins[[i+1]]$Mean,
                          Phal_min = phalloidins[[i+1]]$Min,
                          Phal_max = phalloidins[[i+1]]$Max,
                          Phal_int_den = phalloidins[[i+1]]$IntDen,
                          Phal_raw_int_den = phalloidins[[i+1]]$RawIntDen,
                          POPC_mean = popcs[[i+1]]$Mean,
                          POPC_min = popcs[[i+1]]$Min,
                          POPC_max = popcs[[i+1]]$Max,
                          POPC_int_den = popcs[[i+1]]$IntDen,
                          POPC_raw_int_den = popcs[[i+1]]$RawIntDen)
  total_well <- rbind(Well_pic1, Well_pic2) #combine all 3 pics from the same well together
  total_well <- total_well[total_well$DAPI_max > 0,] #Take out DAPI- cells
  total_well <- subset(total_well, select = -DAPI_max) #Dont want the DAPI column 
  write.csv(total_well,file = "(output location)/(name file).csv" )
}
#C2
{i <-8
  Well_pic1 <- data.frame(Well_image_num = dapis[[i]]$Label,
                          Mask_number = dapis[[i]]$X, 
                          DAPI_max = dapis[[i]]$Max, 
                          Area = phalloidins[[i]]$Area, 
                          Circularity = phalloidins[[i]]$Circ.,
                          AR = phalloidins[[i]]$AR, 
                          Roundness = phalloidins[[i]]$Round,
                          Solidity = phalloidins[[i]]$Solidity,
                          Phal_mean = phalloidins[[i]]$Mean,
                          Phal_min = phalloidins[[i]]$Min,
                          Phal_max = phalloidins[[i]]$Max,
                          Phal_int_den = phalloidins[[i]]$IntDen,
                          Phal_raw_int_den = phalloidins[[i]]$RawIntDen,
                          POPC_mean = popcs[[i]]$Mean,
                          POPC_min = popcs[[i]]$Min,
                          POPC_max = popcs[[i]]$Max,
                          POPC_int_den = popcs[[i]]$IntDen,
                          POPC_raw_int_den = popcs[[i]]$RawIntDen)
  Well_pic2 <- data.frame(Well_image_num = dapis[[i+1]]$Label,
                          Mask_number = dapis[[i+1]]$X, 
                          DAPI_max = dapis[[i+1]]$Max, 
                          Area = phalloidins[[i+1]]$Area, 
                          Circularity = phalloidins[[i+1]]$Circ.,
                          AR = phalloidins[[i+1]]$AR, 
                          Roundness = phalloidins[[i+1]]$Round,
                          Solidity = phalloidins[[i+1]]$Solidity,
                          Phal_mean = phalloidins[[i+1]]$Mean,
                          Phal_min = phalloidins[[i+1]]$Min,
                          Phal_max = phalloidins[[i+1]]$Max,
                          Phal_int_den = phalloidins[[i+1]]$IntDen,
                          Phal_raw_int_den = phalloidins[[i+1]]$RawIntDen,
                          POPC_mean = popcs[[i+1]]$Mean,
                          POPC_min = popcs[[i+1]]$Min,
                          POPC_max = popcs[[i+1]]$Max,
                          POPC_int_den = popcs[[i+1]]$IntDen,
                          POPC_raw_int_den = popcs[[i+1]]$RawIntDen)
  total_well <- rbind(Well_pic1, Well_pic2)
  total_well <- total_well[total_well$DAPI_max > 0,] #Take out DAPI- cells
  total_well <- subset(total_well, select = -DAPI_max) #Dont want the DAPI column 
  write.csv(total_well,file = "(output location)/(name file).csv" )
}
#D2
{i <-10
  Well_pic1 <- data.frame(Well_image_num = dapis[[i]]$Label,
                          Mask_number = dapis[[i]]$X, 
                          DAPI_max = dapis[[i]]$Max, 
                          Area = phalloidins[[i]]$Area, 
                          Circularity = phalloidins[[i]]$Circ.,
                          AR = phalloidins[[i]]$AR, 
                          Roundness = phalloidins[[i]]$Round,
                          Solidity = phalloidins[[i]]$Solidity,
                          Phal_mean = phalloidins[[i]]$Mean,
                          Phal_min = phalloidins[[i]]$Min,
                          Phal_max = phalloidins[[i]]$Max,
                          Phal_int_den = phalloidins[[i]]$IntDen,
                          Phal_raw_int_den = phalloidins[[i]]$RawIntDen,
                          POPC_mean = popcs[[i]]$Mean,
                          POPC_min = popcs[[i]]$Min,
                          POPC_max = popcs[[i]]$Max,
                          POPC_int_den = popcs[[i]]$IntDen,
                          POPC_raw_int_den = popcs[[i]]$RawIntDen)
  Well_pic2 <- data.frame(Well_image_num = dapis[[i+1]]$Label,
                          Mask_number = dapis[[i+1]]$X, 
                          DAPI_max = dapis[[i+1]]$Max, 
                          Area = phalloidins[[i+1]]$Area, 
                          Circularity = phalloidins[[i+1]]$Circ.,
                          AR = phalloidins[[i+1]]$AR, 
                          Roundness = phalloidins[[i+1]]$Round,
                          Solidity = phalloidins[[i+1]]$Solidity,
                          Phal_mean = phalloidins[[i+1]]$Mean,
                          Phal_min = phalloidins[[i+1]]$Min,
                          Phal_max = phalloidins[[i+1]]$Max,
                          Phal_int_den = phalloidins[[i+1]]$IntDen,
                          Phal_raw_int_den = phalloidins[[i+1]]$RawIntDen,
                          POPC_mean = popcs[[i+1]]$Mean,
                          POPC_min = popcs[[i+1]]$Min,
                          POPC_max = popcs[[i+1]]$Max,
                          POPC_int_den = popcs[[i+1]]$IntDen,
                          POPC_raw_int_den = popcs[[i+1]]$RawIntDen)
  total_well <- rbind(Well_pic1, Well_pic2) #combine all 3 pics from the same well together
  total_well <- total_well[total_well$DAPI_max > 0,] #Take out DAPI- cells
  total_well <- subset(total_well, select = -DAPI_max) #Dont want the DAPI column 
  write.csv(total_well,file = "(output location)/(name file).csv" )
}
