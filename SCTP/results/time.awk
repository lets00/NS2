#!/usr/bin/awk -f

BEGIN{
  i=0.0;
  FS=" "
  n=0;
}

{
  getline
  if (($2 - i) > 5.0){
    time[n]=i;    
    n++;
    nextfile;
    exit
  }
  else
    i=$2; 
}

END{
  for (x=0;x<n;x++)
    print FILENAME " " time[x];  
}
