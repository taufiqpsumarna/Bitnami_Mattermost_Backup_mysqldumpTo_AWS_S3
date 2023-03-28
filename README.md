# Mattermost MySQL Backup and Upload to AWS S3
This script creates a backup of a Mattermost MySQL database and uploads it to an AWS S3 bucket. The script is written in Bash.

<img src =./images/mm_mysqldump_AWS_S3.png/><br>
<hr>

## Prerequisites
- mysqldump command must be installed
- AWS CLI must be installed and configured with valid credentials
- AWS S3 Bucket Access wit IAM  ``ListBucket, PutObject, GetObject and DeleteObject`` has been configured
- Mattermost database credentials must be available
- Mattermost service must be installed and running on the same machine where this script will be executed

<hr>

## Installation
1. Download the mattermost-mysql-backup.sh file to your local machine,Name the file something like **mattermost-mysql-backup.sh**
2. Open the file and set the following variables:
```
MYSQLDUMP: path to the mysqldump command
DB_USER: Mattermost database username
DB_PASS: Mattermost database password
DB_NAME: Mattermost database name
S3_BUCKET_NAME: name of the AWS S3 bucket where the backup will be uploaded
S3_BUCKET_PATH: path to the folder where the backup will be uploaded
BACKUP_DIR: path to the folder where the backup will be stored temporarily
```
3. Save the file.

<hr>

## Usage
1. Open the terminal on the machine where Mattermost is installed.
2. Navigate to the folder where the mattermost-mysql-backup.sh file is stored.
3. Execute the following command to make the script executable:

```
chmod +x mattermost-mysql-backup.sh
```
To run the script, execute the following command:
```
./mattermost-mysql-backup.sh
```

<hr>

## Logs
The script generates logs of its execution. You can view the logs by running the following command in the terminal:

```
cat /var/log/mattermost-mysql-backup.log
```

<hr>

## Automation
You can automate the backup process by setting up a cron job to run the script at a scheduled time. Here's an example cron job to run the script every day at 1am:

```
0 1 * * * /path/to/mattermost-mysql-backup.sh >> /var/log/mattermost-mysql-backup.log 2>&1
```

<hr>

## This Scipts has been tested on
```
PRETTY_NAME="Debian GNU/Linux 11 (bullseye)"
NAME="Debian GNU/Linux"
VERSION_ID="11"
VERSION="11 (bullseye)"
VERSION_CODENAME=bullseye
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"

Linux localhost 5.10.0-21-cloud-amd64 #1 SMP Debian 5.10.162-1 (2023-01-21) x86_64 GNU/Linux
```

```
Mattermost Team Edition packaged by Bitnami
Version:        v7.9.0
GitCommit:      56199911e811bb8d96f719049fecc3c64fce9782
GitTreeState:   "clean"
BuildDate:      2023-03-01T08:32:15Z
GoVersion:      go1.18.1
Compiler:       gc
Platform:       linux/amd64
```

<hr>

## License
This project is licensed under the MIT License.

<hr>

## Credit

**This Scripts Created By* [taufiqpsumarna](https://github.com/taufiqpsumarna)

*Reference:* https://mkyong.com/linux/linux-script-to-backup-mysql-to-amazon-s3/
