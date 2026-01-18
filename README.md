A container solution to creating NTFS filesystems, having only a Linux host and Docker runtime/compose.

In this example a device provided by the OS (Synology DSM) at `/dev/usb1` is used.

## Review settings

In compose, specify /dev/usb1 and /dev/usb1p1 as devices to share from the host

## Boot container
```
docker compose up -d
docker compose exec ubuntu bash
```

## In container shell
```
# create partitions
parted /dev/usb1
mklabel gpt
# warning: couldn't inform kernel. recommend reboot
quit
# restart container

# start container
# continue partitions
parted /dev/usb1
mkpart primary ntfs 0% 100%
quit

# format
mkfs.ntfs -f /dev/usb1p1

# check it passes
ntfsfix /dev/usb1p1

# add volume label
ntfslabel --force /dev/usb1p1 LABELHERE

# verify volume label
blkid /dev/usb1p1
```

## On host
```
# Mount
mount -t ntfs-3g /dev/usb1p1 /mnt

# Check size
df -h /mnt
```