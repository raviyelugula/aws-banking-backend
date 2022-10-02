import json
from sqlalchemy import create_engine
from datetime import datetime

def lambda_handler(event, context):
    try:
        print('=============')
        print(event)
        print('=============')
        db_conn_str = f'mysql+pymysql://ravi:pswd@ip/mysql'
        db_engine = create_engine(db_conn_str)
        db_conn = db_engine.connect()
        current_date = datetime.now().strftime('%Y-%m-%d')


        print(f"insert into Account (program_id, customer_id, account_status, account_type, date_uploaded, date_created) values {event['program_id'],event['customer_id'],event['account_status'],event['account_type'],current_date,current_date}")
        
        result = db_engine.execute(f"insert into Account (program_id, customer_id, account_status, account_type, date_uploaded, date_created) values {event['program_id'],event['customer_id'],event['account_status'],event['account_type'],current_date,current_date}")
        
        id = result.lastrowid
        
        db_conn.close()

        return {
            'statusCode': 200,
            'body': json.dumps(f'account_id created is: {id}')
            }
    except Exception as e:
        return {
            'statusCode': 400,
            'body': json.dumps(f'{e}')
            }

