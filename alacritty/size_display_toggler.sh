#!/bin/env bash

display_inf=$(xrandr | grep primary)

echo $display_inf

if [[ $display_inf ==  *"eDP-1"*  ]]; then
	# go bigger
	sed 's/size = 12/size = 16/' .config/alacritty/alacritty.toml > .config/alacritty/alacritty_cpy.toml
else
	# go smaller
	sed 's/size = 16/size = 12/' .config/alacritty/alacritty.toml > .config/alacritty/alacritty_cpy.toml
fi


mv .config/alacritty/alacritty_cpy.toml .config/alacritty/alacritty.toml

alacritty migrate
