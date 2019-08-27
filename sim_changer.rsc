:global usedsim  [/system routerboard modem get sim-slot ]
:global targetsim a
:if ( $usedsim = "a") do={
:log info "SIM_CHANGE - Modem-using sim a"
:set targetsim b
:log info "SIM_CHANGE - Target sim - b"
} else={
:log info "SIM_CHANGE - Modem-using sim b"
:log info "SIM_CHANGE - Target sim - a"
}

:log info "SIM_CHANGE- switching  sim-slot to another one"
/system routerboard modem set sim-slot=$targetsim
:delay 180

:log info "SIM_CHANGE - testing VPN connection..."

:if ([/ping 8.8.8.8 count=5] = 0) do={
:log info "SIM_CHANGE - Looks like not working... Rollback to previous SIM"    
/system routerboard modem set sim-slot=$usedsim
} else={
:log info "SIM_CHANGE - Looks like it works."
}
