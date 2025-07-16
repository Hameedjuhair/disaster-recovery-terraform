import boto3

def lambda_handler(event, context):
    client = boto3.s3
    response = client.copy_object(
        CopySource={'Bucket': 'source-bucket', 'Key': 'data.sql'},
        Bucket='dr-bucket',
        Key='restore.sql'
    )
    return {"status": "DR triggered"}
