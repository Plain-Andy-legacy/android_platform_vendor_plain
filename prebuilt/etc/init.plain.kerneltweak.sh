#!/system/bin/sh
sysrw
propcompare(){
  echo "Setting tcpcong"
  setprop persist.sys.tcpcong $(getprop persist.sys.stocktcpcong)
  echo "Setting scheduler"
  setprop persist.sys.scheduler $(getprop persist.sys.stockscheduler)
  echo "Setting gov"
  setprop persist.sys.gov $(getprop persist.sys.stockgov)
  echo "Setting minkhz"
  setprop persist.sys.minkhz $(getprop persist.sys.stockminkhz)
  echo "Setting maxkhz"
  setprop persist.sys.maxkhz $(getprop persist.sys.stockmaxkhz)
  echo "Setting maxkhz2"
  setprop persist.sys.maxkhz2 $(getprop persist.sys.stockmaxkhz)
  echo "Setting minkhz2"
  setprop persist.sys.minkhz2 $(getprop persist.sys.stockminkhz)
  echo "Setting gov2"
  setprop persist.sys.gov2 $(getprop persist.sys.stockgov)
  if [[ $(getprop persist.sys.enable_plaintweak) == "1" ]]; then
  if [ -e $EXTERNAL_STORAGE/plaintweak ]; then
  echo "Sourcing $EXTERNAL_STORAGE/plaintweak"
	for line in $(cat $EXTERNAL_STORAGE/plaintweak)
	do
	setprop persist.sys.$(echo $line | sed s'/=/ /')
  echo $(echo $line | sed s'/=.*/ /')"found; is now set for"$(echo $line | sed s'/.*=/ /')
	done
	fi
  fi
}
main(){
echo "Plain-Tweak online; (Re)Starting service"
echo $(getprop persist.sys.tcpcong) > /proc/sys/net/ipv4/tcp_congestion_control
echo $(getprop persist.sys.scheduler) > /sys/block/mmcblk0/queue/scheduler
echo $(getprop persist.sys.gov) > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo $(getprop persist.sys.minkhz) > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo $(getprop persist.sys.maxkhz) > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
}
if [[ $(getprop persist.sys.enable_plaintweak) == "0" ]]; then
setprop persist.sys.tcpcong $(getprop persist.sys.stocktcpcong)
setprop persist.sys.scheduler $(getprop persist.sys.stockscheduler)
setprop persist.sys.gov $(getprop persist.sys.stockgov)
setprop persist.sys.minkhz $(getprop persist.sys.stockminkhz)
setprop persist.sys.maxkhz $(getprop persist.sys.stockmaxkhz)
setprop persist.sys.maxkhz2 $(getprop persist.sys.stockmaxkhz)
setprop persist.sys.minkhz2 $(getprop persist.sys.stockminkhz)
setprop persist.sys.gov2 $(getprop persist.sys.stockgov)
fi
propcompare
main
sysro
exit
