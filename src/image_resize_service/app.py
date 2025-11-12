# lambda take image, resizes it
# s3 location where image will be loaded
# s3 location where resized image will be added
# event to to trigger lambda
# lambda execution role with s3 read/write permissions, cloudwatch log permissions
# resource based policy to allow s3 to invoke lambda

import boto3
import logging
import PIL import Image


s3_client = boto3.client('s3')

logger = logging.getLogger()
logger.setLevel("INFO")

OUTPUT_SIZE = (128, 128)

def lambda_handler(event, context):
    # event contains info about s3 bucket and object key
    # context contains runtime info (function name, arn, memeory limit, log group)
    print("Event: ", event)
    print("Context: ", context)
    logger.info("Lambda Name: ", context.function_name)
    logger.info("Lambda Memeory limit: ", context.memory_limit_in_mb)

    try:
        # image = Image.open('')
        # resized_image = image.resize(OUTPUT_SIZE, Image.LANCZOS)
        # resized_image.save('')
        pass
    except Exception as e:
        logger.exception("Exception occurred: ", str(e))

    return {'statusCode': 200, 'body': 'Image resized successfully'}