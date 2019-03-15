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
sudo wget -O 8video.mp4 https://www.dropbox.com/s/ma7vxehxhndmkf7/4%20Track%20Recording.mp4?dl=0
sudo cp 8video.mp4 1video.mp4
sudo cp 8video.mp4 1holding.mp4
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

# restart nginx with new config. Set it to start on boot.
sudo /usr/local/nginx/sbin/nginx
sudo cp /usr/local/nginx/scripts/nginxrestart.sh /etc/init.d && sudo update-rc.d /etc/init.d/nginxrestart.sh defaults

#make a little announcment with useful data for the user
WANIP=$(curl -s http://whatismyip.akamai.com/)
echo "Send source RTMP input on port 1935 to $WANIP" 
echo " "
echo "Add www-data ALL=NOPASSWD: /bin/bash to sudo visudo"
echo " "
