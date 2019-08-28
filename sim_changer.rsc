/system script
add dont-require-permissions=no name=sim_changer  policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":global usedsim  [/system routerboard modem get sim-slot ]\r\
    \n:global targetsim a\r\
    \n:if ( \$usedsim = \"a\") do={\r\
    \n:log info \"SIM_CHANGE - Modem-using sim a\"\r\
    \n:set targetsim b\r\
    \n:log info \"SIM_CHANGE - Target sim - b\"\r\
    \n} else={\r\
    \n:log info \"SIM_CHANGE - Modem-using sim b\"\r\
    \n:log info \"SIM_CHANGE - Target sim - a\"\r\
    \n}\r\
    \n\r\
    \n:log info \"SIM_CHANGE- switching  sim-slot to another one\"\r\
    \n/system routerboard modem set sim-slot=\$targetsim\r\
    \n:delay 180\r\
    \n\r\
    \n:log info \"SIM_CHANGE - testing  connection...\"\r\
    \n\r\
    \n:if ([/ping 8.8.8.8 count=5] = 0) do={\r\
    \n:log info \"SIM_CHANGE - Looks like not working... Rollback to previous SIM\"    \r\
    \n/system routerboard modem set sim-slot=\$usedsim\r\
    \n} else={\r\
    \n:log info \"SIM_CHANGE - Looks like it works.\"\r\
    \n}\r\
    \n"
