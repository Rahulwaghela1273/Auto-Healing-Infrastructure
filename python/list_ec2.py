import sys
import boto3
from botocore.exceptions import (
    ClientError,
    EndpointConnectionError,
    NoCredentialsError,
    PartialCredentialsError,
)

try:
    ec2 = boto3.client("ec2")
    response = ec2.describe_instances()

    instances_found = False

    for reservation in response["Reservations"]:
        for instance in reservation["Instances"]:
            instances_found = True
            print(
                f"Instance ID: {instance['InstanceId']}, "
                f"State: {instance['State']['Name']}"
            )

    if not instances_found:
        print("No EC2 instances found.")

except EndpointConnectionError:
    print("Cannot connect to AWS/Floci. Check the endpoint.")
    sys.exit(1)

except (NoCredentialsError, PartialCredentialsError):
    print("AWS credentials are missing or incomplete.")
    sys.exit(1)

except ClientError as error:
    print(f"AWS API request failed: {error}")
    sys.exit(1)
