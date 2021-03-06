YYDOY = function(dat,todssat,century){
  #---------------------------------------------------------#
  #--- Function to convert regular dates in DSSAT format ---#
  #---------------------------------------------------------#
  #--- Murilo Vianna, Jul-2018
  #--- Usage: 
  #---    dat:        The data to be converted (single or vector) in the R Date format YYYY-MM-DD or YYDOY (DSSAT)
  #---    todssat:    A logical. If true the convertion YYYY-MM-DD -> YYDOY will be the output, if false YYDOY -> YYYY-MM-DD
  #---    century:    If todssat = f: specify the century of data (e.g. 1900, 2000), this is a limitation of DSSAT format
  #---------------------------------------------------------#
  
  if(missing(todssat)){todssat=T}
  
  if(todssat){
    #--- Test data
    if(typeof(dat) == "character" & nchar(dat[1]) > 7){
      #--- convert dat to date if not done before
      dat = as.Date(dat)
    }
    #--- dat still not as date stop
    if(typeof(dat) != "double"){stop("Input data is not in Date format (YYYY-MM-DD). Please check dat format.")}
    
    #--- Converts from YYYY-MM-DD to YYDOY format
    year = format(as.Date(dat), "%Y")
    doy  = as.Date(dat) - as.Date(paste0(year,"-01-01")) + 1  
    
    #--- Re-build DSSAT DATE format (YYDOY)
    return (paste0(substr(year,3,4),sprintf("%003.0f",doy)))    
  }else{
    
    #--- check if century is set otherwise default=2000
    if(missing(century)){century=2000}
    
    #--- Test data
    if(typeof(dat) != "character" | nchar(dat[1]) != 5){stop("Input data is not in DSSAT Date format (YYDOY). Please check dat format.")}
    
    #--- passing data
    doy = as.numeric(substr(dat,3,5))
    year= as.numeric(substr(dat,1,2))
    
    
    #--- Re-build DATE format (YYYY-MM-DD)
    return(as.Date(paste0(century+year,"-01-01")) + (doy - 1)) 
    
  }
}
