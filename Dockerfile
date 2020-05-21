FROM tanmaniac/opencv3-cudagl

LABEL maintainer "Jaled Moustafa Calvo <j.moustafa@sialitech.com>"

# install prerequisites
RUN apt-get update \
 && apt-get install -y wget git curl nano sed 

# install Cudnn
ENV CUDNN_VERSION 7.6.0.64
RUN apt-get update && apt-get install -y --no-install-recommends \
            libcudnn7=$CUDNN_VERSION-1+cuda10.0 \
            libcudnn7-dev=$CUDNN_VERSION-1+cuda10.0 && \
    apt-mark hold libcudnn7 && \
    rm -rf /var/lib/apt/lists/*

# compile repository
RUN git clone https://github.com/AlexeyAB/darknet.git
WORKDIR /darknet
RUN sed -i -e 's/GPU=0/GPU=1/g' Makefile \
 && sed -i -e 's/CUDNN=0/CUDNN=1/g' Makefile \
 && sed -i -e 's/OPENCV=0/OPENCV=1/g' Makefile \
 && sed -i -e 's/LIBSO=0/LIBSO=1/g' Makefile \
 && sed -i -e 's/DEBUG=0/DEBUG=1/g' Makefile
RUN make
# download yoloV3 weights
RUN mkdir weights \
 && wget -P /darknet/weights https://github.com/AlexeyAB/darknet/releases/download/darknet_yolo_v3_optimal/yolov4.weights
