#!/bin/sh

######################
# setup build system #
######################

sudo apt-get update
sudo apt-get install build-essential python quilt devscripts python-setuptools python3
sudo apt-get install libssl-dev
sudo apt-get install cmake
sudo apt-get install libc-ares-dev
sudo apt-get install uuid-dev
sudo apt-get install daemon

#########################################
# build and install libwebsockets 2.2.0 #
#########################################

# echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> tar zxvf libwebsockets-2.2.0.tar.gz"
tar zxvf libwebsockets-2.2.0.tar.gz
# echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> cd libwebsockets-2.2.0"
cd libwebsockets-2.2.0
# echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> mkdir build"
mkdir build
# echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> cd build"
cd build
# echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> sudo cmake .."
sudo cmake ..
# echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> sudo make install"
sudo make install
# echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> sudo ldconfig"
sudo ldconfig
# echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> cd ../.."
cd ../..

###########################
# unpack mosquitto 1.4.11 #
###########################

# echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> tar zxvf mosquitto-1.4.11.tar.gz"
tar zxvf mosquitto-1.4.11.tar.gz
# echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> cd mosquitto-1.4.11"
cd mosquitto-1.4.11

#####################
# enable websockets #
#####################

# echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> sed -ie 's/WITH_WEBSOCKETS:=no/WITH_WEBSOCKETS:=yes/' config.mk"
sed -ie 's/WITH_WEBSOCKETS:=no/WITH_WEBSOCKETS:=yes/' config.mk

######################################
# build and install mosquitto 1.4.11 #
######################################

# echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> sudo make"
sudo make
# echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> sudo make install"
sudo make install
# echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> sed -ie 's/#port 1883/#port 1883\nlistener 1883\nlistener 9001\nprotocol websockets/' mosquitto.conf"
sed -ie 's/#port 1883/#port 1883\nlistener 1883\nlistener 9001\nprotocol websockets/' mosquitto.conf
# echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> sudo cp mosquitto.conf /etc/mosquitto"
sudo cp mosquitto.conf /etc/mosquitto

#######
# end #
#######
