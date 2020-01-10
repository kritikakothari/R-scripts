#You need to create a Master Batch file specific to your experiment.
#Change variable total_rotation base don your batch file
#This code runs one SQX file, for running multiple files, you can generate a string of multiple SQX file names


wd = "C:/DSSAT47"             #working directory
setwd(paste0(wd,"/Sequence"))

xfile = "UFGA7804.SQX"        #Specify the SQX you want to run. If you have multiple files, you can create names in loop
total_rotation <- 6           #How many total rotaions do you have? Change this based on your sequence
ds_v <- 47                    #DSSAT version

spaces = paste0(rep(" ", 33), collapse = "")  #Spaces in the batch call between actual letters, 
                                              #need to change only if running another crop instead of SEQUENCE

#--- Read Master batch file
bfile = readLines(paste(wd,"/DSSATBatch_Master.v47",sep=""))

#Replace file name in the Master Batch file
for (i in 1:total_rotation){
    bfile[i+3] = gsub("XXXX9999.SQX",xfile,bfile[i+3])
}

#--- generate/write new batch file
write(bfile,file = paste("C:/DSSAT",ds_v,"/SEQUENCE/","DSSBatch.v",ds_v,sep = ""))


#Running the command through cmd
system(paste("C:/DSSAT",ds_v,"/DSCSM0",ds_v,".EXE"," Q ",paste("DSSBatch.v",ds_v,sep=""),sep=""),show.output.on.console = T)


#removing undesired variables
rm(bfile,ds_v,wd,total_rotation,xfile,i,spaces)
