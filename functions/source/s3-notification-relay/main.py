import json
import os

import boto3

sns_client = boto3.client("sns")
TARGET_ARN = os.getenv("SNS_TOPIC_ARN")


def publisher(msg):
    sns_client.publish(
        TargetArn=TARGET_ARN,
        Message=json.dumps({"default": json.dumps(msg)}),
        Subject='Cloudtrail event from bucket',
        MessageStructure='json',
    )


def get_record_object_key(record):
    return record["s3"]["object"]["key"]


def handler(event, context):
    records = event["Records"]
    cloudtrail_notification = {
        "s3Bucket": records[0]["s3"]["bucket"]["name"],
        "s3ObjectKey": [get_record_object_key(record) for record in records]
    }
    publisher(cloudtrail_notification)
