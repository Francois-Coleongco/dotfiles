#!/bin/bash

# ATTENTION: in order for this script to work, you need to run the link and discord_hosts commands below first, then `echo $discord_hosts > discord_old_hosts`

link="https://discord.com/api/download?platform=linux&format=deb"

discord_hosts=$(host $(echo $link | sed 's|https\?://\([^/]*\).*|\1|') | awk '{print $4}')

echo "" > discord_ip_stats
old_hosts=$(cat "discord_old_hosts")

for ip in $discord_hosts
do

	if [[ $ip =~ ^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; then
			echo "Valid IPv4 address form"
			if [[ "${old_hosts}" == *${ip}* ]]; then
				echo "verified" >> discord_ip_stats
			else
				echo "DANGER" >> discord_ip_stats
			fi
	else
			echo "Invalid IPv4 address"
	fi
done

if [[ "$(cat "discord_ip_stats")" == *"DANGER"* ]]; then
	echo "POSSIBLE HIJACK"
else
	echo "GOOD DOMAINS"
	wget $link -O discord.deb
	sudo apt install ./discord.deb
fi

