
import sys
import boto3
from botocore.exceptions import ClientError, EndpointConnectionError

if len(sys.argv) <= 1:
    print("Usage: python python/start_ec2.py <INSTANCE_ID>")
    sys.exit(1)

instance_id = sys.argv[1]

ec2 = boto3.client("ec2")

try:
    ec2.start_instances(
        InstanceIds=[instance_id]
    )
    print(f"Start request sent for instance: {instance_id}")

except ClientError as error:
    print(f"Failed to start instance {instance_id}: {error}")
    sys.exit(1)

except EndpointConnectionError:
    print("Could not connect to AWS/Floci. Check the endpoint and try again.")
    sys.exit(1)
