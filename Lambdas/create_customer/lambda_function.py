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

        print(f"insert into Customer (ssn, dob, first_name, last_name, phone, email, customer_address) values {event['ssn'],event['dob'],event['first_name'],event['last_name'],event['phone'],event['email'],event['customer_address']}")
        
        result = db_engine.execute(f"insert into Customer (ssn, dob, first_name, last_name, phone, email, customer_address) values {event['ssn'],event['dob'],event['first_name'],event['last_name'],event['phone'],event['email'],event['customer_address']}")
        
        id = result.lastrowid
        
        db_conn.close()

        return {
            'statusCode': 200,
            'body': json.dumps(f'cusomter id created is: {id}')
            }
    except Exception as e:
        return {
            'statusCode': 400,
            'body': json.dumps(f'{e}')
            }

