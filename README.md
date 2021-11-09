# rasp-ros-py2-cv2
## About

This is a Dockerfile for installing image management python libraries in a Docker container applied on a raspberry pi 3B architecture.

This Dockerfile is running opencv-contrib with aruco's and numpy's libraries in ros:kinetic-ros-base-xenial.

This way of implementing cv2 was necessary because of the raspberry architecture's incompatibility of using some "apt-get install" commands compared to normal computers.
