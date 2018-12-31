#!/bin/bash

sudo apt-get update && sudo apt-get -y install build-essential checkinstall libpcre3 libpcre3-dev libssl-dev libx264-dev libx265-dev libnuma-dev libvpx-dev libfdk-aac-dev libmp3lame-dev libopus-dev libsdl2-dev libfreetype6-dev libass-dev libtool git zip unzip curl php-cli php-mbstring php-fpm php-mysql php7.0-curl php7.0-gd autoconf automake cmake git-core pkg-config texinfo zlib1g-dev uuid-dev libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev nasm yasm htop ffmpeg
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

sudo git clone https://github.com/regstuff/InstagramLive-PHP.git
sudo composer install -d InstagramLive-PHP/

# Download and move config files
cd ~/MLS/scripts/
sudo mkdir images
sudo mkdir tmp
cd images
sudo wget -O holding.mp4 https://www.dropbox.com/s/yllnqcwe942xpt9/2018-11-04%2020-53-26.mp4?dl=0
sudo wget -O lowerthird.png https://www.dropbox.com/s/f053xt0o4ekaifz/lowerthird.png?dl=0
sudo chgrp -R www-data ~/MLS
sudo chmod g+rw -R ~/MLS
sudo cp -R ~/MLS/scripts /usr/local/nginx
sudo chmod +x -R /usr/local/nginx/scripts
sudo cp /usr/local/nginx/scripts/.htpasswd /usr/local/nginx/conf/
sudo cp /etc/php/7.0/fpm/php.ini /etc/php/7.0/fpm/php.old
sudo cp /usr/local/nginx/scripts/php.ini /etc/php/7.0/fpm/
sudo rm -R ~/MLS/scripts/images
sudo rm -R ~/MLS/scripts/tmp
sudo systemctl restart php7.0-fpm

sudo cp /usr/local/nginx/scripts/nginx.conf /usr/local/nginx/conf/
sudo rm -R /usr/local/nginx/html
sudo cp -R ~/MLS/html /usr/local/nginx

#Setup HLS & Recording folders
sudo mkdir /usr/local/nginx/html/hls
sudo chmod -R 777 /usr/local/nginx/html/hls

sudo mkdir /usr/local/nginx/html/recording
sudo chmod -R 777 /usr/local/nginx/html/recording

#Configure TImezone For Recording Timestamps
sudo dpkg-reconfigure tzdata

#Install FFMPEG Controller
cd ~ && sudo wget https://github.com/zeromq/libzmq/releases/download/v4.2.2/zeromq-4.2.2.tar.gz && tar xvzf zeromq-4.2.2.tar.gz && cd zeromq-4.2.2
./configure && sudo make install && sudo ldconfig

cd ~
git clone git://git.ffmpeg.org/rtmpdump
cd rtmpdump
make SYS=posix
sudo checkinstall --pkgname=rtmpdump --pkgversion="2:$(date +%Y%m%d%H%M)-git" --backup=no --deldoc=yes --fstrans=no --default

#install Latest FFMPEG
sudo mkdir -p ~/ffmpeg_sources ~/bin && cd ~ && sudo wget -O ffmpeg-snapshot.tar.bz2 https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 && tar xjvf ffmpeg-snapshot.tar.bz2 
cd ffmpeg && \
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
  --enable-librtmp \
  --enable-network \
  --enable-nonfree && \
PATH="$HOME/bin:$PATH" make

sudo make install && hash -r

./configure --enable-libzmq && make && make tools/zmqsend

#Shift Latest FFMPEG & Tools to local/bin folder to avoid config with apt-get FFMPEG
sudo cp -R tools /usr/local/bin
sudo cp ~/ffmpeg_build/bin/ffmpeg /usr/local/bin
sudo cp ~/ffmpeg_build/bin/ffplay /usr/local/bin
sudo cp ~/ffmpeg_build/bin/ffprobe /usr/local/bin

# restart nginx with the new config and wait for input.
sudo /usr/local/nginx/sbin/nginx

#make a little announcment with useful data for the user
WANIP=$(curl -s http://whatismyip.akamai.com/)
echo "Send source RTMP input on port 1935 to $WANIP" 
echo " "
echo "Add www-data ALL=NOPASSWD: /bin/bash to sudo visudo"
echo " "
