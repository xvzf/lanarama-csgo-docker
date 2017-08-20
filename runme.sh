#!/bin/sh
cd $HOME/csgo-server

#./update.sh

LAUNCHVALS="-game csgo -usercon -strictportbind -port 27015 +clientport 27005 +tv_port 27020 +sv_setsteamaccount  -tickrate 64 +map de_mirage +servercfgfile csgoserver.cfg -maxplayers_override 16 +mapgroup mg_active +game_mode 0 +game_type 0 +host_workshop_collection  +workshop_start_map  -authkey -unsecure -insecure"
csgo/srcds_run $LAUNCHVALS
