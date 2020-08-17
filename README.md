# NGINX Server

Default login/password for server is admin/nimda

# Need to install on Ubuntu 16.04
Don't use Ubuntu minimal. Use the regular 16.04 image

#Steps to Install
1. On the terminal, type: cd ~ && sudo git clone git://github.com/regstuff/MLS.git && cd MLS && sudo ./install-nginx.sh
2. The install is automatic, except for the initial part where you need to choose your timezone for time and date configguration. (Note: Installation may take upto an hour on a single CPU instance)
3. Once installation is complete, on the terminal, type: sudo visudo 
4. To the bottom of the file that opens up, add: www-data ALL=NOPASSWD: /bin/bash, /bin/ls
5. Ctrl+o to save the file, Ctrl+X to exit the notepad editor. This process is needed to give the NGINX server access to the shell scripting
6. If you want to allow uploading of lowerthirds from the settings page, on the terminal, type: sudo nano /etc/php/7.0/fpm/php.ini
7. Find the line ;file_uploads = On --> Usually around line 800. Ctrl+Shift+_ and type 800 to get there quick
8. Remove the semicolon in front of the line to uncomment it.
9. Ctrl+o to save the file, Ctrl+X to exit the notepad editor.
10. Optional additional step: By default, all server logs are cleared on instance boot. This will ensure hardisk space isn't consumed too much. If you wish, you can retain them. On the terminal, type: sudo nano /etc/init.d/nginxrestart.sh
11. In the editor, comment the line (Add # before it): sudo rm /usr/local/nginx/logs/*.log
12. Ctrl+o to save the file, Ctrl+X to exit the notepad editor.
13. Installation is complete


