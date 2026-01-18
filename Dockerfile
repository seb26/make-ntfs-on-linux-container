FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        fdisk \
        ntfs-3g \
        parted \
        udev
CMD ["bash"]
