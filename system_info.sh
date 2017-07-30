
# This is a script to display informations about you linux machine

display_user(){
  local user= $(whoami)
  display_header "Current user informations"
  echo "Current user is : $user"
  echo "User home is : $HOME"
  echo "Current path is : $PATH"
  echo "Current shel is : $SHELL"
  echo "Current user groups : $(groups $user)"
  echo "Current user ids: $(id $user)"
  pause

}

display_network(){
  display_header "Network informations"
  devices=$(netstat -i | cut -d" " -f1 | egrep -v "^Kernel|Iface|lo")
  echo "Total network interfaces found : $(wc -w <<<${devices})"
  echo "Network interface: ${devices}"
  echo "===== IP adress informations ====="
  ip -4 address show
  echo "===== Network routing ====="
  netstat -nr
  echo "==== Interface traffic information ====="
  netstat -i
  pause 
}


display_disk(){
  display_header "Disk usage informations"
  df -h 
  pause

}


display_memory(){
   display_header "Memory Informations"
   free -m 
   echo "===== Virtual memory ====="
   vmstat
   pause
}



display_hostname(){
    local dns=$(sed -e '/^$/d' /etc/resolv.conf | awk '{if (tolower($1)=="nameserver") print $2}')
    display_header "Hostname informations"
    echo "Hostname is : $(hostname -s)"
    echo "DNS domain is : $(hostname -d)"
    echo "Fully domain name is : $(hostname -f)"
    echo "IP adress is : $(hostname -i)"
    echo "DNS name servers are : ${dns} "
    pause
}


display_kernel(){
    display_header "Kernel informations"
    echo "Kernel name is : $(uname)"
    echo "The network hostname is : $( uname -n)"
    echo "Kernel version is : $(uname -v) "
    echo "Kernel release : $(uname -r) "
    echo "Hardware architecture: $(uname -m)"
    echo "All kernel info : $(uname -a)"
    pause
}

display_header(){
    local name="$@"
    echo "============================="
    echo " ${name}"
    echo "============================="
}

pause(){
    read -p "Press [Enter] key to continue..." fackEnterKey
}

show_menu(){
    clear
    echo "============================="
    echo "========= Meniu ============="
    echo "============================="
    echo "1. Display kernel informations"
    echo "2. Display hostname informations"
    echo "3. Display RAM memory"
    echo "4. Display disk usage"
    echo "5. Display network informations"
    echo "6. Display current user informations"
    echo "7. Exit"
}

read_menu(){
    local option
    read -p "Insert your option [1-5]: " option
    case $option in
         1) display_kernel;;
         2) display_hostname;;
         3) display_memory;;
         4) display_disk;;
         5) display_network;;
         6) display_user;; 
         7) exit 0 ;;
         *) echo -e "Option is not avaible"
    esac
}

while true
do 
 show_menu
 read_menu
done
