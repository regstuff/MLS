#!/bin/bash

#Configure Timezone For Recording Timestamps
sudo dpkg-reconfigure tzdata

#Install dependencies
sudo apt-get update && sudo apt-get -y install build-essential checkinstall libpcre3 libpcre3-dev libssl-dev libx264-dev libx265-dev libnuma-dev libvpx-dev libfdk-aac-dev libmp3lame-dev libopus-dev libsdl2-dev libfreetype6-dev libass-dev libtool git zip unzip curl php7.0-cli php7.0-mbstring php7.0-fpm php7.0-mysql php7.0-curl php7.0-gd php7.0-bcmath autoconf automake cmake git-core pkg-config texinfo zlib1g-dev uuid-dev libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev nasm yasm htop ffmpeg youtube-dl

#Install NGINX with RTMP module
sudo mkdir ~/build && cd ~/build
sudo git clone git://github.com/arut/nginx-rtmp-module.git
sudo wget http://nginx.org/download/nginx-1.13.12.tar.gz
sudo tar xzf nginx-1.13.12.tar.gz
cd nginx-1.13.12
sudo ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module
echo "Hold on! NGINX is installing."
sudo make -s
sudo make install

# Clear the default nginx.config
sudo /usr/local/nginx/sbin/nginx -s stop
sudo cp /usr/local/nginx/conf/nginx.conf /usr/local/nginx/conf/nginx.old

#Install PHP
cd ~
sudo curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

#Install Instagram-Live scripts
sudo git clone https://github.com/regstuff/InstagramLive-PHP.git
sudo composer install -d InstagramLive-PHP/

# Download and move config files
cd ~/MLS/scripts/
sudo mkdir images
sudo mkdir tmp
cd images
sudo wget -O 1lowerthird.png https://www.dropbox.com/s/f053xt0o4ekaifz/lowerthird.png?dl=0
sudo wget -O 1video.mp4 https://www.dropbox.com/s/6rh85usdpj6v9kf/1video-OBS-profile.mp4?dl=0
sudo wget -O 1holding.mp4 https://www.dropbox.com/s/lz0file9wizdytt/1holding.mp4?dl=0
sudo cp /usr/local/nginx/scripts/images/1lowerthird.png /usr/local/nginx/scripts/images/2lowerthird.png
sudo cp /usr/local/nginx/scripts/images/1lowerthird.png /usr/local/nginx/scripts/images/3lowerthird.png
sudo cp /usr/local/nginx/scripts/images/1lowerthird.png /usr/local/nginx/scripts/images/4lowerthird.png
sudo cp /usr/local/nginx/scripts/images/1lowerthird.png /usr/local/nginx/scripts/images/5lowerthird.png
sudo cp /usr/local/nginx/scripts/images/1lowerthird.png /usr/local/nginx/scripts/images/6lowerthird.png
sudo cp /usr/local/nginx/scripts/images/1lowerthird.png /usr/local/nginx/scripts/images/7lowerthird.png
sudo cp /usr/local/nginx/scripts/images/1lowerthird.png /usr/local/nginx/scripts/images/8lowerthird.png
sudo cp /usr/local/nginx/scripts/images/1lowerthird.png /usr/local/nginx/scripts/images/9lowerthird.png
sudo cp /usr/local/nginx/scripts/images/1lowerthird.png /usr/local/nginx/scripts/images/10lowerthird.png
sudo cp /usr/local/nginx/scripts/images/1video.mp4 /usr/local/nginx/scripts/images/2video.mp4
sudo cp /usr/local/nginx/scripts/images/1video.mp4 /usr/local/nginx/scripts/images/3video.mp4
sudo cp /usr/local/nginx/scripts/images/1video.mp4 /usr/local/nginx/scripts/images/4video.mp4
sudo cp /usr/local/nginx/scripts/images/1video.mp4 /usr/local/nginx/scripts/images/5video.mp4
sudo cp /usr/local/nginx/scripts/images/1video.mp4 /usr/local/nginx/scripts/images/6video.mp4
sudo cp /usr/local/nginx/scripts/images/1video.mp4 /usr/local/nginx/scripts/images/7video.mp4
sudo cp /usr/local/nginx/scripts/images/1video.mp4 /usr/local/nginx/scripts/images/8video.mp4
sudo cp /usr/local/nginx/scripts/images/1video.mp4 /usr/local/nginx/scripts/images/9video.mp4
sudo cp /usr/local/nginx/scripts/images/1video.mp4 /usr/local/nginx/scripts/images/10video.mp4
sudo cp /usr/local/nginx/scripts/images/1holding.mp4 /usr/local/nginx/scripts/images/2holding.mp4
sudo cp /usr/local/nginx/scripts/images/1holding.mp4 /usr/local/nginx/scripts/images/3holding.mp4
sudo cp /usr/local/nginx/scripts/images/1holding.mp4 /usr/local/nginx/scripts/images/4holding.mp4
sudo cp /usr/local/nginx/scripts/images/1holding.mp4 /usr/local/nginx/scripts/images/5holding.mp4
sudo cp /usr/local/nginx/scripts/images/1holding.mp4 /usr/local/nginx/scripts/images/6holding.mp4
sudo cp /usr/local/nginx/scripts/images/1holding.mp4 /usr/local/nginx/scripts/images/7holding.mp4
sudo cp /usr/local/nginx/scripts/images/1holding.mp4 /usr/local/nginx/scripts/images/8holding.mp4
sudo cp /usr/local/nginx/scripts/images/1holding.mp4 /usr/local/nginx/scripts/images/9holding.mp4
sudo cp /usr/local/nginx/scripts/images/1holding.mp4 /usr/local/nginx/scripts/images/10holding.mp4

#Shift files to right locations
sudo chgrp -R www-data ~/MLS
sudo chmod g+rw -R ~/MLS
sudo cp -R ~/MLS/scripts /usr/local/nginx
sudo chmod +x -R /usr/local/nginx/scripts
sudo cp /usr/local/nginx/scripts/1.sh /usr/local/nginx/scripts/2.sh
sudo cp /usr/local/nginx/scripts/1.sh /usr/local/nginx/scripts/3.sh
sudo cp /usr/local/nginx/scripts/1.sh /usr/local/nginx/scripts/4.sh
sudo cp /usr/local/nginx/scripts/1.sh /usr/local/nginx/scripts/5.sh
sudo cp /usr/local/nginx/scripts/1.sh /usr/local/nginx/scripts/6.sh
sudo cp /usr/local/nginx/scripts/1.sh /usr/local/nginx/scripts/7.sh
sudo cp /usr/local/nginx/scripts/1.sh /usr/local/nginx/scripts/8.sh
sudo cp /usr/local/nginx/scripts/1.sh /usr/local/nginx/scripts/9.sh
sudo cp /usr/local/nginx/scripts/1.sh /usr/local/nginx/scripts/10.sh
sudo cp /usr/local/nginx/scripts/.htpasswd /usr/local/nginx/conf/
sudo cp /etc/php/7.0/fpm/php.ini /etc/php/7.0/fpm/php.old
sudo cp /usr/local/nginx/scripts/php.ini /etc/php/7.0/fpm/
sudo rm -R ~/MLS/scripts/images
sudo rm -R ~/MLS/scripts/tmp
sudo systemctl restart php7.0-fpm

sudo cp /usr/local/nginx/scripts/nginx.conf /usr/local/nginx/conf/
sudo rm -R /usr/local/nginx/html
sudo cp -R ~/MLS/html /usr/local/nginx
sudo cp /usr/local/nginx/html/1.php /usr/local/nginx/html/2.php
sudo cp /usr/local/nginx/html/1.php /usr/local/nginx/html/3.php
sudo cp /usr/local/nginx/html/1.php /usr/local/nginx/html/4.php
sudo cp /usr/local/nginx/html/1.php /usr/local/nginx/html/5.php
sudo cp /usr/local/nginx/html/1.php /usr/local/nginx/html/6.php
sudo cp /usr/local/nginx/html/1.php /usr/local/nginx/html/7.php
sudo cp /usr/local/nginx/html/1.php /usr/local/nginx/html/8.php
sudo cp /usr/local/nginx/html/1.php /usr/local/nginx/html/9.php
sudo cp /usr/local/nginx/html/1.php /usr/local/nginx/html/10.php

#Setup HLS & Recording folders
sudo mkdir /usr/local/nginx/html/hls
sudo chmod -R 777 /usr/local/nginx/html/hls

sudo mkdir /usr/local/nginx/html/recording
sudo chmod -R 777 /usr/local/nginx/html/recording

#Install FFMPEG Controller
cd ~ && sudo wget https://github.com/zeromq/libzmq/releases/download/v4.2.2/zeromq-4.2.2.tar.gz && tar xvzf zeromq-4.2.2.tar.gz && cd zeromq-4.2.2
./configure && sudo make install && sudo ldconfig

#Install FFMPEG Components
cd ~
git clone git://git.ffmpeg.org/rtmpdump
cd rtmpdump
make SYS=posix
sudo checkinstall --pkgname=rtmpdump --pkgversion="2:$(date +%Y%m%d%H%M)-git" --backup=no --deldoc=yes --fstrans=no --default

sudo mkdir -p ~/ffmpeg_sources ~/bin && cd ~ && sudo wget -O ffmpeg-snapshot.tar.bz2 https://www.dropbox.com/s/ouciwwc2wpjpf4e/ffmpeg-snapshot.tar.bz2?dl=0 && tar xjvf ffmpeg-snapshot.tar.bz2

#Install SRT Components
cd ~/ffmpeg_sources
sudo git clone --depth 1 https://github.com/Haivision/srt.git && sudo mkdir srt/build && cd srt/build
sudo cmake -DCMAKE_INSTALL_PREFIX="$HOME/ffmpeg_build" -DENABLE_C_DEPS=ON -DENABLE_SHARED=OFF -DENABLE_STATIC=ON ..
sudo make
sudo make install

#install Latest FFMPEG
cd ~/ffmpeg && \
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
  --prefix="$HOME/ffmpeg_build" \
  --pkg-config-flags="--static" \
  --extra-cflags="-I$HOME/ffmpeg_build/include" \
  --extra-ldflags="-L$HOME/ffmpeg_build/lib" \
  --extra-libs="-lpthread -lm" \
  --enable-gpl \
  --enable-libass \
  --enable-libfdk-aac \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libx264 \
  --enable-libx265 \
  --enable-libzmq \
  --enable-libsrt \
  --enable-network \
  --enable-nonfree && \
PATH="$HOME/bin:$PATH" make

sudo make install && hash -r

./configure --enable-libzmq && make && make tools/zmqsend

#Shift Latest FFMPEG & Tools to local/bin folder to avoid config with apt-get FFMPEG
sudo cp -R tools /usr/local/bin && sudo cp ~/ffmpeg_build/bin/ffmpeg /usr/local/bin && sudo cp ~/ffmpeg_build/bin/ffplay /usr/local/bin && sudo cp ~/ffmpeg_build/bin/ffprobe /usr/local/bin

#Shift Instagram-Live to generic folder
sudo cp -R ~/InstagramLive-PHP /usr/local/nginx/scripts/ && sudo mv /usr/local/nginx/scripts/InstagramLive-PHP/ /usr/local/nginx/scripts/InstagramLive-PHP1/
sudo cp -R /usr/local/nginx/scripts/InstagramLive-PHP1/ /usr/local/nginx/scripts/InstagramLive-PHP2/
sudo cp -R /usr/local/nginx/scripts/InstagramLive-PHP1/ /usr/local/nginx/scripts/InstagramLive-PHP3/
sudo cp -R /usr/local/nginx/scripts/InstagramLive-PHP1/ /usr/local/nginx/scripts/InstagramLive-PHP4/
sudo cp -R /usr/local/nginx/scripts/InstagramLive-PHP1/ /usr/local/nginx/scripts/InstagramLive-PHP5/
sudo cp -R /usr/local/nginx/scripts/InstagramLive-PHP1/ /usr/local/nginx/scripts/InstagramLive-PHP6/
sudo cp -R /usr/local/nginx/scripts/InstagramLive-PHP1/ /usr/local/nginx/scripts/InstagramLive-PHP7/
sudo cp -R /usr/local/nginx/scripts/InstagramLive-PHP1/ /usr/local/nginx/scripts/InstagramLive-PHP8/
sudo cp -R /usr/local/nginx/scripts/InstagramLive-PHP1/ /usr/local/nginx/scripts/InstagramLive-PHP9/
sudo cp -R /usr/local/nginx/scripts/InstagramLive-PHP1/ /usr/local/nginx/scripts/InstagramLive-PHP10/

sudo cp -R ~/ffmpeg_sources/srt /usr/local/nginx/scripts/
sudo cp -R ~/MLS /usr/local/nginx/scripts

# restart nginx with new config. Set it to start on boot.
sudo /usr/local/nginx/sbin/nginx
sudo cp /usr/local/nginx/scripts/nginxrestart.sh /etc/init.d && sudo update-rc.d nginxrestart.sh defaults

#make a little announcment with useful data for the user
WANIP=$(curl -s http://whatismyip.akamai.com/)
echo "Send source RTMP input on port 1935 to $WANIP" 
echo " "
echo "Add www-data ALL=NOPASSWD: /bin/bash to sudo visudo"
echo " "
