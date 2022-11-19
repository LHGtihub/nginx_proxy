echo  $#

echo $@

if [ $@ -eq 1 ] 
then 
   echo "参数1个"
 else 
  echo "参数不能大于"
fi

#str="avc"


#if [ ${#str} > 0  ] 
#then
# echo ${#str}
#else 
#  echo "null"
#fi
