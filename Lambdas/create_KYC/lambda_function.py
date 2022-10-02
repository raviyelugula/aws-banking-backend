import json
from sqlalchemy import create_engine

def lambda_handler(event, context):
    try:
        print('=============')
        print(event)
        print('=============')
        db_conn_str = f'mysql+pymysql://ravi:pswd@ip/mysql'
        db_engine = create_engine(db_conn_str)
        db_conn = db_engine.connect()

        print(f"insert into KYC (ssn, phone, email, kyc_status, comments, customer_id) values {event['ssn'],event['phone'],event['email'],event['kyc_status'],event['comments'],event['customer_id']}")
        
        result = db_engine.execute(f"insert into KYC (ssn, phone, email, kyc_status, comments, customer_id) values {event['ssn'],event['phone'],event['email'],event['kyc_status'],event['comments'],event['customer_id']}")
        
        id = result.lastrowid
        
        db_conn.close()

        return {
            'statusCode': 200,
            'body': json.dumps(f'program_id in KYC is: {id}')
            }
    except Exception as e:
        return {
            'statusCode': 400,
            'body': json.dumps(f'{e}')
            }

