import json
import boto3
import random
import time
from datetime import datetime, timedelta
import uuid

# Initialize Kinesis client
kinesis_client = boto3.client('kinesis', region_name='us-east-1')

def generate_sample_transaction():
    """Generate a sample transaction"""
    return {
        'transaction_id': str(uuid.uuid4()),
        'user_id': f"user_{random.randint(1000, 9999)}",
        'amount': round(random.uniform(10, 5000), 2),
        'currency': random.choice(['USD', 'EUR', 'GBP']),
        'transaction_type': random.choice(['purchase', 'withdrawal', 'deposit', 'transfer']),
        'merchant_id': f"merchant_{random.randint(100, 999)}",
        'timestamp': datetime.utcnow().isoformat() + 'Z',
        'ip_address': f"{random.randint(1,255)}.{random.randint(1,255)}.{random.randint(1,255)}.{random.randint(1,255)}",
        'device_id': str(uuid.uuid4())
    }

def send_test_data(stream_name, num_records=100):
    """Send test data to Kinesis stream"""
    print(f"Starting to send {num_records} records to stream: {stream_name}")
    
    for i in range(num_records):
        transaction = generate_sample_transaction()
        
        try:
            response = kinesis_client.put_record(
                StreamName=stream_name,
                Data=json.dumps(transaction),
                PartitionKey=transaction['user_id']
            )
            
            print(f"Sent record {i+1}: {response['SequenceNumber']}")
            time.sleep(0.1)  # Small delay to avoid throttling
            
        except Exception as e:
            print(f"Error sending record {i+1}: {str(e)}")
            break
    
    print("Finished sending test data")

if __name__ == "__main__":
    # Use your actual naming convention
    project_name = "financial-analytics-platform"
    environment = "dev"
    stream_name = f"{project_name}-{environment}-transactions"
    
    print(f"Stream name: {stream_name}")
    send_test_data(stream_name, 50)