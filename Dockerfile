FROM ubuntu:16.04
MAINTAINER Matthias Riegler <matthias@xvzf.tech>

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install lib32gcc1 curl net-tools
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV USER csgo-lanarama

RUN useradd $USER
ENV HOME /home/$USER
RUN mkdir $HOME
RUN chown $USER:$USER $HOME

ENV SERVER $HOME/csgo-server
RUN mkdir $SERVER

RUN chown -R $USER:$USER $SERVER

USER $USER
RUN curl http://media.steampowered.com/client/steamcmd_linux.tar.gz | tar -C $SERVER -xvz
ADD ./update.sh $SERVER/update.sh
ADD ./csgo_ds.txt $SERVER/csgo_ds.txt
RUN $SERVER/update.sh

ADD ./configs/ai.cfg $SERVER/csgo/csgo/cfg/ai.cfg
ADD ./configs/banned_ip.cfg $SERVER/csgo/csgo/cfg/banned_ip.cfg
ADD ./configs/banned_user.cfg $SERVER/csgo/csgo/cfg/banned_user.cfg
ADD ./configs/buypresetsdefault_ct.vdf $SERVER/csgo/csgo/cfg/buypresetsdefault_ct.vdf
ADD ./configs/buypresetsdefault_ter.vdf $SERVER/csgo/csgo/cfg/buypresetsdefault_ter.vdf
ADD ./configs/config.360.cfg $SERVER/csgo/csgo/cfg/config.360.cfg
ADD ./configs/config_default.cfg $SERVER/csgo/csgo/cfg/config_default.cfg
ADD ./configs/controller.360.cfg $SERVER/csgo/csgo/cfg/controller.360.cfg
ADD ./configs/controller_accelerated_hp.cfg $SERVER/csgo/csgo/cfg/controller_accelerated_hp.cfg
ADD ./configs/controller.cfg $SERVER/csgo/csgo/cfg/controller.cfg
ADD ./configs/controller.vdf $SERVER/csgo/csgo/cfg/controller.vdf
ADD ./configs/coop $SERVER/csgo/csgo/cfg/coop
ADD ./configs/cpu_level_0_pc.ekv $SERVER/csgo/csgo/cfg/cpu_level_0_pc.ekv
ADD ./configs/cpu_level_0_pc_ss.ekv $SERVER/csgo/csgo/cfg/cpu_level_0_pc_ss.ekv
ADD ./configs/cpu_level_1_pc.ekv $SERVER/csgo/csgo/cfg/cpu_level_1_pc.ekv
ADD ./configs/cpu_level_1_pc_ss.ekv $SERVER/csgo/csgo/cfg/cpu_level_1_pc_ss.ekv
ADD ./configs/cpu_level_2_pc.ekv $SERVER/csgo/csgo/cfg/cpu_level_2_pc.ekv
ADD ./configs/cpu_level_2_pc_ss.ekv $SERVER/csgo/csgo/cfg/cpu_level_2_pc_ss.ekv
ADD ./configs/csgoserver.cfg $SERVER/csgo/csgo/cfg/csgoserver.cfg
ADD ./configs/default.cfg $SERVER/csgo/csgo/cfg/default.cfg
ADD ./configs/entity.cfg $SERVER/csgo/csgo/cfg/entity.cfg
ADD ./configs/esl1on1aim.cfg $SERVER/csgo/csgo/cfg/esl1on1aim.cfg
ADD ./configs/esl1on1awp.cfg $SERVER/csgo/csgo/cfg/esl1on1awp.cfg
ADD ./configs/esl1on1.cfg $SERVER/csgo/csgo/cfg/esl1on1.cfg
ADD ./configs/esl1on1hg.cfg $SERVER/csgo/csgo/cfg/esl1on1hg.cfg
ADD ./configs/esl1on1ka.cfg $SERVER/csgo/csgo/cfg/esl1on1ka.cfg
ADD ./configs/esl2on2aim.cfg $SERVER/csgo/csgo/cfg/esl2on2aim.cfg
ADD ./configs/esl2on2awp.cfg $SERVER/csgo/csgo/cfg/esl2on2awp.cfg
ADD ./configs/esl2on2.cfg $SERVER/csgo/csgo/cfg/esl2on2.cfg
ADD ./configs/esl2on2hg.cfg $SERVER/csgo/csgo/cfg/esl2on2hg.cfg
ADD ./configs/esl3on3.cfg.cfg $SERVER/csgo/csgo/cfg/esl3on3.cfg.cfg
ADD ./configs/esl5on5.cfg $SERVER/csgo/csgo/cfg/esl5on5.cfg
ADD ./configs/eslgotv.cfg $SERVER/csgo/csgo/cfg/eslgotv.cfg
ADD ./configs/game360.cfg $SERVER/csgo/csgo/cfg/game360.cfg
ADD ./configs/game.cfg $SERVER/csgo/csgo/cfg/game.cfg
ADD ./configs/gamemode_armsrace.cfg $SERVER/csgo/csgo/cfg/gamemode_armsrace.cfg
ADD ./configs/gamemode_cassual.cfg $SERVER/csgo/csgo/cfg/gamemode_cassual.cfg
ADD ./configs/gamemode_casual_1.cfg $SERVER/csgo/csgo/cfg/gamemode_casual_1.cfg
ADD ./configs/gamemode_casual.cfg $SERVER/csgo/csgo/cfg/gamemode_casual.cfg
ADD ./configs/gamemode_competitive2v2.cfg $SERVER/csgo/csgo/cfg/gamemode_competitive2v2.cfg
ADD ./configs/gamemode_competitive.cfg $SERVER/csgo/csgo/cfg/gamemode_competitive.cfg
ADD ./configs/gamemode_cooperative.cfg $SERVER/csgo/csgo/cfg/gamemode_cooperative.cfg
ADD ./configs/gamemode_coopmission.cfg $SERVER/csgo/csgo/cfg/gamemode_coopmission.cfg
ADD ./configs/gamemode_custom.cfg $SERVER/csgo/csgo/cfg/gamemode_custom.cfg
ADD ./configs/gamemode_deathmatch.cfg $SERVER/csgo/csgo/cfg/gamemode_deathmatch.cfg
ADD ./configs/gamemode_demolition.cfg $SERVER/csgo/csgo/cfg/gamemode_demolition.cfg
ADD ./configs/gamemode_teamdeathmatch.cfg $SERVER/csgo/csgo/cfg/gamemode_teamdeathmatch.cfg
ADD ./configs/gamemode_training.cfg $SERVER/csgo/csgo/cfg/gamemode_training.cfg
ADD ./configs/gameps3.cfg $SERVER/csgo/csgo/cfg/gameps3.cfg
ADD ./configs/give_all_items.cfg $SERVER/csgo/csgo/cfg/give_all_items.cfg
ADD ./configs/gpu_level_0_pc.ekv $SERVER/csgo/csgo/cfg/gpu_level_0_pc.ekv
ADD ./configs/gpu_level_1_pc.ekv $SERVER/csgo/csgo/cfg/gpu_level_1_pc.ekv
ADD ./configs/gpu_level_2_pc.ekv $SERVER/csgo/csgo/cfg/gpu_level_2_pc.ekv
ADD ./configs/gpu_level_3_pc.ekv $SERVER/csgo/csgo/cfg/gpu_level_3_pc.ekv
ADD ./configs/gpu_mem_level_0_pc.ekv $SERVER/csgo/csgo/cfg/gpu_mem_level_0_pc.ekv
ADD ./configs/gpu_mem_level_1_pc.ekv $SERVER/csgo/csgo/cfg/gpu_mem_level_1_pc.ekv
ADD ./configs/gpu_mem_level_2_pc.ekv $SERVER/csgo/csgo/cfg/gpu_mem_level_2_pc.ekv
ADD ./configs/lab.cfg $SERVER/csgo/csgo/cfg/lab.cfg
ADD ./configs/listenserver.cfg $SERVER/csgo/csgo/cfg/listenserver.cfg
ADD ./configs/map_edit.cfg $SERVER/csgo/csgo/cfg/map_edit.cfg
ADD ./configs/mem_level_0_pc.ekv $SERVER/csgo/csgo/cfg/mem_level_0_pc.ekv
ADD ./configs/mem_level_1_pc.ekv $SERVER/csgo/csgo/cfg/mem_level_1_pc.ekv
ADD ./configs/mem_level_2_pc.ekv $SERVER/csgo/csgo/cfg/mem_level_2_pc.ekv
ADD ./configs/moddefaults_mac.txt $SERVER/csgo/csgo/cfg/moddefaults_mac.txt
ADD ./configs/moddefaults.txt $SERVER/csgo/csgo/cfg/moddefaults.txt
ADD ./configs/modsettings.cfg $SERVER/csgo/csgo/cfg/modsettings.cfg
ADD ./configs/nav_bindings.cfg $SERVER/csgo/csgo/cfg/nav_bindings.cfg
ADD ./configs/navedit.cfg $SERVER/csgo/csgo/cfg/navedit.cfg
ADD ./configs/op08_bloodletter.cfg $SERVER/csgo/csgo/cfg/op08_bloodletter.cfg
ADD ./configs/op08_bounty_hunter.cfg $SERVER/csgo/csgo/cfg/op08_bounty_hunter.cfg
ADD ./configs/op08_flying_scoutsman.cfg $SERVER/csgo/csgo/cfg/op08_flying_scoutsman.cfg
ADD ./configs/op08_headshots.cfg $SERVER/csgo/csgo/cfg/op08_headshots.cfg
ADD ./configs/op08_heavy_assault_suit.cfg $SERVER/csgo/csgo/cfg/op08_heavy_assault_suit.cfg
ADD ./configs/op08_hunter_gatherers.cfg $SERVER/csgo/csgo/cfg/op08_hunter_gatherers.cfg
ADD ./configs/op08_stab_stab_zap.cfg $SERVER/csgo/csgo/cfg/op08_stab_stab_zap.cfg
ADD ./configs/op08_team_deathmatch.cfg $SERVER/csgo/csgo/cfg/op08_team_deathmatch.cfg
ADD ./configs/op08_trigger_discipline.cfg $SERVER/csgo/csgo/cfg/op08_trigger_discipline.cfg
ADD ./configs/op08_weapons_expert.cfg $SERVER/csgo/csgo/cfg/op08_weapons_expert.cfg
ADD ./configs/settings_default.scr $SERVER/csgo/csgo/cfg/settings_default.scr
ADD ./configs/sfm_defaultanimationgroups.txt $SERVER/csgo/csgo/cfg/sfm_defaultanimationgroups.txt
ADD ./configs/start.cfg $SERVER/csgo/csgo/cfg/start.cfg
ADD ./configs/steering_wheel.cfg $SERVER/csgo/csgo/cfg/steering_wheel.cfg
ADD ./configs/test.cfg $SERVER/csgo/csgo/cfg/test.cfg
ADD ./configs/thirdperson.cfg $SERVER/csgo/csgo/cfg/thirdperson.cfg
ADD ./configs/thirdperson_joy360.cfg $SERVER/csgo/csgo/cfg/thirdperson_joy360.cfg
ADD ./configs/thirdperson_keypad.cfg $SERVER/csgo/csgo/cfg/thirdperson_keypad.cfg
ADD ./configs/thirdperson_mayamode.cfg $SERVER/csgo/csgo/cfg/thirdperson_mayamode.cfg
ADD ./configs/undo360controller.cfg $SERVER/csgo/csgo/cfg/undo360controller.cfg
ADD ./configs/user_default.scr $SERVER/csgo/csgo/cfg/user_default.scr
ADD ./configs/valve.rc $SERVER/csgo/csgo/cfg/valve.rc

USER root
RUN chmod 755 $SERVER/csgo/csgo/*

USER $USER
ADD ./autoexec.cfg $SERVER/csgo/csgo/cfg/autoexec.cfg
ADD ./runme.sh $SERVER/runme.sh

EXPOSE 27015/udp
EXPOSE 27005/udp
EXPOSE 27020/udp

WORKDIR $SERVER
ENTRYPOINT ["./runme.sh"]
