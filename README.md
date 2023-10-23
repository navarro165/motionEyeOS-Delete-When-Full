# motionEyeOS-Delete-When-Full
This Bash script is designed to manage disk space on a specified drive where camera recordings are stored. It monitors the disk usage, and if it exceeds a defined threshold, it removes the oldest recordings to free up space.

## Usage

1. Ensure that you have configured the user constants in `storage_cleaner.sh`:
    - **Threshold Value**: Adjust the `threshold` value to set the desired disk usage percentage at which the script should start removing old recordings.

    - **Drive Path**: Change the `drive_path` to point to the actual drive path where your camera recordings are stored.

    - **Camera Names**: Modify the `cameras` array to include the names of the camera subdirectories within the target drive.
   
2. Make the script executable by running `chmod +x storage_cleaner.sh`.
3. Add to `crontab -e` to automate the cleanup process.
