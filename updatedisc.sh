#!/bin/bash

cd ~/Downloads
rm Discord -rf
wget -O Discord.tar.gz https://discord.com/api/download\?platform\=linux\&format\=tar.gz
tar -vxf Discord.tar.gz
rm Discord.tar.gz
rm ~/.local/bin/Discord -rf
mv Discord ~/.local/bin/
