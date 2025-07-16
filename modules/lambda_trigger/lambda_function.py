import json
import boto3

def lambda_handler(event, context):
    print("🚨 DR Triggered! Event:")
    print(json.dumps(event))
    
    # You can automate EKS restore, start EC2, notify, etc.
    return {
        'statusCode': 200,
        'body': json.dumps('Disaster Recovery Trigger Executed!')
    }
