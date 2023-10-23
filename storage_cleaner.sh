#!/bin/bash

### USER CONSTANTS ###
######################
threshold=90  # threshold for max disk usage
drive_path='/motioneyes_nvr_ssd'  # drive where recordings are stored

# camera names (subdirectories within the target drive)
cameras=(
  deck_alley_north_view
  deck_alley_south_view
  main_entrance_inside
  rockwell_north_view
  rockwell_south_view
)
######################
######################

# percentage of disk usage on the target drive
disk_usage=$(df -h | awk -v path="$drive_path" '$0 ~ path {print $5}' | tr -d '%')

# if the disk usage is greater than or equal to the threshold, then do the following
if [ $disk_usage -ge $threshold ]; then

  # log record of deletion process
  echo "" >> removed.log
  echo "On $(date -Iseconds), disk_usage is $disk_usage%. Removing the following dirs:" >> removed.log

  # find unique dirs in drive with a YYYY-MM-DD format and then sort them chronologically
  oldest_date_dirs=$(find "$drive_path/" -type d -regextype egrep -regex '.*/[0-9]{4}-[0-9]{2}-[0-9]{2}$' | sed 's/.*\///' | sort -u | sort -t - -k1,1n -k2,2n -k3,3n)

  # get the oldest directory
  oldest_dir=$(echo $oldest_date_dirs | awk '{print $1}')

  # loop through each camera subdirectory and delete the target date subdirectory
  for camera in "${cameras[@]}"; do

    # Delete the directory and its contents and update log
    delete_path="$drive_path/$camera/$oldest_dir"
    rm -rf $delete_path
    echo $delete_path >> removed.log

  done

fi

exit 0
