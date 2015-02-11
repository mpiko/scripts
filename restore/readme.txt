To recover onto a blank drive:
1) run partitions
  partitions will create all of the partitions, filesystems, and swap space

2) run recover
  recover will mount the destination, rsync the entire system over, recreate
  the fstab and grub.cfg, and re-install grub.

I have successfully tested this process a number of times and it works well.


Backups:
To backup a system, simple run 
   "sudo ./backup.sh /mnt"
where /mnt is the mount point of the backup drive. The backup.sh script will 
also dump the partition table out of a file and put it in the root of the 
recovery disk.


