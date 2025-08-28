import json
import base64
import boto3
import logging
from datetime import datetime
from decimal import Decimal
import os

# Setup logging
logger = logging.getLogger()
logger.setLevel(os.getenv('LOG_LEVEL', 'INFO'))

s3_client = boto3.client('s3')

def handler(event, context):
    """
    Process Kinesis records containing financial transactions
    """
    processed_records = 0
    failed_records = 0
    
    try:
        for record in event['Records']:
            try:
                # Decode Kinesis record
                payload = base64.b64decode(record['kinesis']['data'])
                data = json.loads(payload)
                
                # Validate and enrich transaction data
                processed_transaction = process_transaction(data)
                
                # Store processed transaction
                store_processed_transaction(processed_transaction)
                processed_records += 1
                
            except Exception as e:
                logger.error(f"Failed to process record: {str(e)}")
                failed_records += 1
                continue
        
        logger.info(f"Processed {processed_records} records, {failed_records} failed")
        
        return {
            'statusCode': 200,
            'body': json.dumps({
                'processed': processed_records,
                'failed': failed_records
            })
        }
        
    except Exception as e:
        logger.error(f"Handler error: {str(e)}")
        raise

def process_transaction(transaction_data):
    """
    Validate and enrich transaction data
    """
    # Basic validation
    required_fields = ['transaction_id', 'user_id', 'amount', 'currency', 'timestamp']
    for field in required_fields:
        if field not in transaction_data:
            raise ValueError(f"Missing required field: {field}")
    
    # Enrich with additional metadata
    processed = {
        **transaction_data,
        'processed_timestamp': datetime.utcnow().isoformat(),
        'amount_usd': convert_to_usd(transaction_data['amount'], transaction_data['currency']),
        'risk_score': calculate_basic_risk_score(transaction_data)
    }
    
    return processed

def convert_to_usd(amount, currency):
    """
    Basic currency conversion (you'd integrate with real exchange rate API)
    """
    # Placeholder conversion rates
    rates = {
        'USD': 1.0,
        'EUR': 1.08,
        'GBP': 1.25,
        'JPY': 0.007
    }
    
    return float(amount) * rates.get(currency, 1.0)

def calculate_basic_risk_score(transaction_data):
    """
    Calculate basic risk score (enhanced in later phases)
    """
    risk_score = 0.0
    
    # High amount transactions
    if float(transaction_data['amount']) > 10000:
        risk_score += 0.3
    
    # Add more risk factors here
    
    return min(risk_score, 1.0)

def store_processed_transaction(transaction):
    """
    Store processed transaction in S3
    """
    bucket = os.getenv('S3_BUCKET')
    
    # Create partition key based on timestamp
    timestamp = datetime.fromisoformat(transaction['timestamp'].replace('Z', '+00:00'))
    key = f"transactions/{timestamp.strftime('%Y/%m/%d/%H')}/{transaction['transaction_id']}.json"
    
    s3_client.put_object(
        Bucket=bucket,
        Key=key,
        Body=json.dumps(transaction, default=str),
        ContentType='application/json'
    )