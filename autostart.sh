JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.232.b09-0.el7_7.aarch64/
PATH=$PATH:$JAVA_HOME/bin
app='/home/oa_system/target/oasys-0.0.1-SNAPSHOT.jar'
#args='-server -Xms1024m -Xmx1024m -XX:PermSize=128m -XX:SurvivorRatio=2 -XX:+UseParallelGC'
LOGS_FILE=/dev/null
 
cmd=$1
pid=`ps -ef|grep java|grep $app|awk '{print $2}'`
 
startup(){
  aa=`nohup java -jar $args $app >> $LOGS_FILE 2>&1 &`
  echo $aa
}
 
if [ ! $cmd ]; then
  echo "Please specify args 'start|restart|stop'"
  exit
fi
 
if [ $cmd == 'start' ]; then
  if [ ! $pid ]; then
    startup
  else
    echo "$app is running! pid=$pid"
  fi
fi
 
if [ $cmd == 'restart' ]; then
  if [ $pid ]
    then
      echo "$pid will be killed after 3 seconds!"
      sleep 3
      kill -9 $pid
  fi
  startup
fi
 
if [ $cmd == 'stop' ]; then
  if [ $pid ]; then
    echo "$pid will be killed after 3 seconds!"
    sleep 3
    kill -9 $pid
  fi
  echo "$app is stopped"
fi