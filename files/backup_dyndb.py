import boto3
import os
from datetime import datetime

region = os.environ['REGION']
client = boto3.client('dynamodb', region_name=region)
max_backups = int(os.environ['MAX_BACKUPS'])


def lambda_handler(event, context):
    if 'TableName' not in event:
        raise Exception("No table name specified.")
    table_name = event['TableName']

    create_backup(table_name)
    delete_old_backups(table_name)


def create_backup(table_name):
    print("Backing up table:", table_name)
    backup_name = table_name + '-' + datetime.now().strftime('%Y%m%d%H%M%S')

    if max_backups != 0:
        response = client.create_backup(
            TableName=table_name, BackupName=backup_name)

        print(f"Created backup {response['BackupDetails']['BackupName']}")


def delete_old_backups(table_name):
    print("Deleting old backups for table:", table_name)

    backups = client.list_backups(TableName=table_name)

    backup_count = len(backups['BackupSummaries'])
    print('Total backup count:', backup_count)

    if backup_count <= max_backups:
        print("No stale backups. Exiting.")
        return

    # Backups in date descending order (newest to oldest)
    sorted_list = sorted(backups['BackupSummaries'],
                         key=lambda k: k['BackupCreationDateTime'], reverse=True)

    old_backups = sorted_list[max_backups:]

    print(f'Old backups: {old_backups}')

    for backup in old_backups:
        arn = backup['BackupArn']
        print("ARN to delete: " + arn)
        deleted_arn = client.delete_backup(BackupArn=arn)
        backup_name = deleted_arn['BackupDescription']['BackupDetails']['BackupName']
        status = deleted_arn['BackupDescription']['BackupDetails']['BackupStatus']
        print(f'BackupName: {backup_name}, Status: {status}')

    return
