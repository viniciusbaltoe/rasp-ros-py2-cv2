# rasp-ros-py2-cv2

This Dockerfile is running opencv-contrib with aruco's and numpy's library in ros:kinetic-ros-base-xenial.

The implementation of cv2 in this way was necessary because his normal implementation on the raspberry pi — using apt-get install cv2, opencv, opencv-contrib or whatnot — doesn't work.
