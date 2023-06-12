#/bin/bash
#Variables

#mysqldump path
MYSQLDUMP= #example /opt/bitnami/mysql/bin/mysqldump

#Timestamp
TIME=`/bin/date +%d-%m-%Y-%T`

#Mattermost DB USER and PASS
DB_USER="" #example dbusermm
DB_PASS="" #example 123password
DB_NAME="" #example bitnami_mattermost

S3_BUCKET_NAME=""
S3_BUCKET_PATH="" #example s3://mattermost-backup/mysqldump/

#Backup Filename
FILENAME=${DB_NAME}_${TIME}

#Backup location
BACKUP_DIR="" #example /tmp/dbdump
BACKUP_PATH="$BACKUP_DIR/$FILENAME.sql.gz"
mkdir -p $BACKUP_DIR

#Create Credential File
DB_ACCESS=./tmp/mysqldump/mysql-credentials.cnf

cat <<EOF > $DB_ACCESS
[client]
"user=$DB_USER"
"password=$DB_PASS"
EOF

echo $BACKUP_DEST

echo "Checking Mattermost Service Status..."
/opt/bitnami/ctlscript.sh status

echo "Stopping Mattermost Service..."
/opt/bitnami/ctlscript.sh stop mattermost

echo "Database Dump $DB_NAME..."
#mysqldump -u [user name] –p [password] [options] [database_name] [tablename] > [dumpfilename.sql]
#login database via credential file for more secure access

$MYSQLDUMP --defaults-extra-file=$DB_ACCESS $DB_NAME | gzip > $BACKUP_PATH

#AWS S3 Connection Check
echo "Checking AWS S3 Connection..."
aws s3 ls $S3_BUCKET_NAME

#AWS S3 Upload Dump
echo "Uploading Database Dump To AWS S3"
aws s3 cp $BACKUP_PATH $S3_BUCKET_PATH

#Cleaning temporary file
echo "Cleaning Temporary File"
sudo rm $BACKUP_DIR/*

#All done
echo "Starting Mattermost Service..."
/opt/bitnami/ctlscript.sh start mattermost

echo "Checking Mattermost Service Status..."
#Wait 5 Second To Execute
sleep 5 &&
/opt/bitnami/ctlscript.sh status

echo "Backup available at $S3_BUCKET_PATH$FILENAME.sql.gz"
