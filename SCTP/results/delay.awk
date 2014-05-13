#!/usr/bin/awk -f

BEGIN{
  FS=" "
  scr=0;
  dst=0;
  sum=0;
  avg=0;
  dif=0;
  fwd[0]=0;
  fwd[1]=0;
}

# For process the final to transfer archive
{
  fwd[0]=fwd[1]
  fwd[1]=$2
}

#Send package
/^\+/&&$3==0&&$4==1{
  if(fwd[1] - fwd[2] <5){
    t_scr[scr]=$2
    scr++;
  }
}

#Receive ack package
/^r/ && $3==1 && $4==0{
  if(fwd[1] - fwd[2] <5){
    t_dst[dst]=$2;
    dif= $2 - t_scr[dst];
    dst++;
    sum=sum+dif
    #print "t_scr["dst"]= " t_scr[dst]"\td_dsc["dst"]= "$2"\t"dif
    print dst"\t"dif
  }
}

END{
 #print "Avarage:" sum/dst;
}
