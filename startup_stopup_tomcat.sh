if [ $# -lt 1 ] 
then 
  echo "请输入参数 start 或者 stop" 
  exit
fi


ARRAY_S=(shutdown.sh startup.sh) 

PID=($(ps -ef | grep "tomcat" | grep -v grep | awk '{print $2}'))

init(){
   PID=($(ps -ef | grep "tomcat" | grep -v grep | awk '{print $2}'))
   echo "当前运行的tomcat服务...."${PID[@]}
}

stop_s(){
     ps -ef | grep "tomcat" | grep -v grep | awk '{print "kill -9 "$2}' | sh &
    echo "服务停止完成"
}

start_stop_(){
for var in $*;
do
    sh $var
    echo "-------------------------------->>>>>>>>>>>"$var
if [[ "$var" =~ "shutdown.sh" ]];
then
        echo "stop....tomcat...停止中"  
     else
        echo "start...tomcat...启动中*"
    fi
done
echo "***********************服务启动完成******************"
}


case $@ in 
   "start") #start如果传的是start参数
     BASEDIR=`cd \`dirname $0\`; pwd`   #获取当前绝对路径
  #  * 和 @ 都是获取数组中的所有元素。
    if [[  "${#PID[*]}" -gt "2"  ]]  # 数组中的元素是否大于2
    then
    if [[ "$BASEDIR" =~ "nginx_tomcat" ]];
    then
        start_stop_ `find $BASEDIR/ -name "shutdown.sh"` #调用方法 传递参数
        start_stop_ `find $BASEDIR/ -name "startup.sh"` #调用方法 传递参数
    fi
    else
     if [[ "$BASEDIR" =~ "nginx_tomcat" ]]; #如果当前路径包含“nginx_tomcat” 字符串
    then 
    start_stop_ `find $BASEDIR/ -name "startup.sh"`  #调用方法 传递参数
    fi 
    fi
;;

"stop") #stop 参数
   init
   stop_s
;;

*)  #其他参数
echo "请输入参数 start 或 stop！"
;;
esac #结束标识符
