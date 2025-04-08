#!/bin/env bash

display_inf=$(xrandr | grep "\*")

echo $display_inf

if [[ $display_inf ==  *"1920x1080"*  ]]; then
	# go smaller
	sed 's/size = 14/size = 12/' .config/alacritty/alacritty.toml > .config/alacritty/alacritty_cpy.toml
else
	# go bigger
	sed 's/size = 12/size = 14/' .config/alacritty/alacritty.toml > .config/alacritty/alacritty_cpy.toml
fi


mv .config/alacritty/alacritty_cpy.toml .config/alacritty/alacritty.toml

alacritty migrate
