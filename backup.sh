#!/bin/bash
     # This script archives files from a traget directory in a tar file,
     # which is moved to destination directory specified by the user.
     # This project is in fulfilment of the requirement for the IBM-LCSS
     # course completion. It is a final project an will follow an assessment 
     # layout with markers for work completion
     # Author: Aria Odoh
     # Input:
     # Invoke script with a commad line argument of the target and 
     # destination directories. The script archives all the files in the 
     # target directory. Modify for loop to limit scope as needed
    
     # Output:
     # Tar file with current timestamp in file name in the format: "backup-[CURRENT_TIMESTAMP].tar.gz"
     # This tar file will be located in the specified destination directory 

  # This checks if the number of arguments is correct
  # If the number of arguments is incorrect ( $# != 2) print error message and exit
  if [[ $# != 2 ]]
  then
    echo "backup.sh target_directory_name destination_directory_name"
    exit 1
  fi
  
  # This checks if argument 1 and argument 2 are valid directory paths
  if [[ ! -d $1 ]] || [[ ! -d $2 ]]
  then
    echo "Invalid directory path provided"
    exit 1
  fi
  
  # [TASK 1]
  # Set variables for target and destination directories
  targetDirectory=$1
  destinationDirectory=$2
  
  # [TASK 2]
  # Print target and destination directories
  echo "Target Directory: $targetDirectory"
  echo "Destination Directory: $destinationDirectory"
  
  # [TASK 3]
  # Get current timestamp
  currentTS=$(date +%s)
  
  # [TASK 4]
  # Create backup filename with timestamp
  backupFileName="backup-$currentTS.tar.gz"
  
  # We're going to:
    # 1: Go into the target directory
    # 2: Create the backup file
    # 3: Move the backup file to the destination directory
  
  # To make things easier, we will define some useful variables...
  
  # [TASK 5]
  #specify current working directory for relative as base
  origAbsPath=`pwd`
  
  # [TASK 6]
  # Move to destination directory and save absolute path
  # for future tar file migration
  cd $destinationDirectory
  destDirAbsPath=`pwd`
  
  # [TASK 7]
  # Return to base directory then navigate to target directory 
  # where files to be archived lives
  cd $origAbsPath
  cd $targetDirectory
  
  # [TASK 8]
  # Get timestamp for yesterday from Today's timestamp
  yesterdayTS=$(($currentTS - 24 * 60 * 60))
  
  # Array to store files to backup
  declare -a toBackup
  
  # Loop through files in directory
  for file in *; # [TASK 9]
  do
    # [TASK 10]
    # Get timestamp of file
    fileTS=$(date -r $file +%s)
  
    # Check if file was modified within the last 24 hours
    if (( fileTS >= $yesterdayTS))
    then
      # [TASK 11]
      # Add file to list of files to backup
      toBackup+=($file)
    fi
  done
  
  # [TASK 12]
  # Create tar archive of files to backup
  tar -czvf "$backupFileName" "${toBackup[@]}"
  
  # [TASK 13]
  # Move backup file to destination directory
  mv -i "$backupFileName" "$destinationDirectory"
  
  echo "Backup completed successfully!"
  
  # Congratulations! You completed the final project for this course!
