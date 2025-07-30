import json
import boto3
import os
import logging

dynamodb = boto3.resource('dynamodb')
s3 = boto3.client('s3')
sns = boto3.client('sns')

TABLE_NAME = os.environ['TABLE_NAME']
BUCKET_NAME = os.environ['BUCKET_NAME']
SNS_TOPIC_ARN = os.environ['SNS_TOPIC_ARN']

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    try:
        # Read from DynamoDB
        table = dynamodb.Table(TABLE_NAME)
        response = table.get_item(Key={'id': 'demo'})
        item = response.get('Item', {})

        # Write to S3
        report = json.dumps(item, indent=2)
        s3.put_object(Bucket=BUCKET_NAME, Key='report.json', Body=report)

        # Send SNS notification
        sns.publish(
            TopicArn=SNS_TOPIC_ARN,
            Subject="Lambda Report Uploaded",
            Message="The report.json has been saved to S3."
        )

        logger.info("Success: Data processed.")
        return {
            "statusCode": 200,
            "body": json.dumps({"message": "Success!"})
        }

    except Exception as e:
        logger.error(f"Error: {str(e)}")
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }
