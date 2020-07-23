FROM ros:kinetic-ros-base-xenial

MAINTAINER viniciusbaltoe@gmail.com

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y vim 
RUN	apt-get install -y zip unzip
RUN apt-get install -y wget
 
#Instalaçao dos pacotes necessarios
RUN apt-get install -y libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev
RUN apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
RUN apt-get install -y libxvidcore-dev libx264-dev
RUN apt-get install -y libgtk2.0-dev libgtk-3-dev
RUN apt-get install -y libcanberra-gtk*
RUN apt-get install -y libatlas-base-dev gfortran
RUN apt-get install -y python2.7-dev python3-dev

#Download do codigo fonte
RUN /bin/bash -c "cd ~ \
    && wget -O opencv.zip https://github.com/opencv/opencv/archive/3.4.7.zip \
    && unzip opencv.zip \
    && wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/3.4.7.zip \
    && unzip opencv_contrib.zip"

#Instalação do pip
RUN /bin/bash -c "wget https://bootstrap.pypa.io/get-pip.py \
    && python get-pip.py \
    && python3 get-pip.py \
    && rm -rf ~/.cache/pip"

#Instalaçao do numpy
RUN pip install numpy

#Preparaçao do build usando cmake
RUN /bin/bash -c "cd root/opencv-3.4.7 \
    && mkdir build \
    && cd build"
WORKDIR root/opencv-3.4.7/build

RUN cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib-3.4.7/modules \
    #-D ENABLE_NEON=ON \
    #-D ENABLE_VFPV3=ON \
    -D BUILD_TESTS=OFF \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    #-D OPENCV_ENABLE_NONFREE=ON \
    #-D CMAKE_SHARED_LINKER_FLAGS='-latomic' \
    -D BUILD_EXAMPLES=OFF ..
RUN make -j4

#Instalaçao
RUN make install

#Criaçao de links e cache
RUN ldconfig

#Inicialização do ROS - Completa.
RUN /bin/bash -c "source /opt/ros/kinetic/setup.bash \
	&&  mkdir -p ~/catkin_ws/src \
	&&  cd ~/catkin_ws/src \
	&&  catkin_init_workspace \
	&&  cd ~/catkin_ws \
	&&  catkin_make \
    &&  source devel/setup.bash"

WORKDIR root/catkin_ws/src

# Pacotes CV2 + ROS
RUN apt install  -y ros-kinetic-cv-bridge 
