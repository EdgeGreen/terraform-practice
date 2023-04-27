import boto3
import json
import os

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table(os.environ.get('DYNAMODB_TABLE'))

def lambda_handler(event, context):
    for record in event['Records']:
        # Check if the S3 event is for a new object being created
        if record['eventName'] == 'ObjectCreated:Put':
            # Get the S3 bucket and object key from the event
            bucket_name = record['s3']['bucket']['name']
            object_key = record['s3']['object']['key']
            object_size = record['s3']['object']['size']

            # Get the object creation time from the S3 metadata
            s3 = boto3.client('s3')
            response = s3.head_object(Bucket=bucket_name, Key=object_key)
            creation_time = response['LastModified'].isoformat()

            # Store the object metadata in DynamoDB
            item = {
                'bucket_name': bucket_name,
                'object_key': object_key,
                'object_size': object_size,
                'creation_date': creation_time,
            }
            table.put_item(Item=item)

    return {
        'statusCode': 200,
        'body': json.dumps('Object metadata stored in DynamoDB')
    }
