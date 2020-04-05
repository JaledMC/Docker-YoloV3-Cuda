# Docker YoloV3
YoloV3 docker with Cuda, Cudnn and Opencv support. Based on [AlexeyAB darknet](https://github.com/AlexeyAB/darknet) and [tanmaniac/opencv3-cudagl](https://hub.docker.com/r/tanmaniac/opencv3-cudagl)

# Prerequisites
* Install [Nvidia driver](https://www.nvidia.com/Download/index.aspx))
* Install [docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

## Build
`docker build -t yolo`
## Run
To run the image with GUI support, first enable docker to access X11s:  
`xhost +local:docker`  
Run the container with Nvidia support and X11 access:  
`docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix --runtime=nvidia --privileged yolo`
