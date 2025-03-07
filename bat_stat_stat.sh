#!/bin/env bash

$(ps -aux | grep "/bin/bash.*bat_stat" > ~/dotfiles/bat_stat_stat)

line_count=$(wc -l < ~/dotfiles/bat_stat_stat)

if [[ $line_count -eq 2 ]]; then

	echo bat_stat on

else

	echo bat_stat off

fi
