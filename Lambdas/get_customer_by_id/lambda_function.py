import json
from sqlalchemy import create_engine

def lambda_handler(event, context):
    try:
        
        db_conn_str = f'mysql+pymysql://ravi:pswd@ip/mysql'
        db_engine = create_engine(db_conn_str)
        db_conn = db_engine.connect()

        result = db_engine.execute(f"select * from Customer where customer_id = {event['customer_id']}")
        values = result.fetchone()
        index = 0
        body = "{"
        for col in result.keys():
            body = body + f'"{col}":"{values[index]}",'
            index = index + 1
        body = body[:-1]+"}"
        body = json.loads(body)
        db_conn.close()

        return {
            'statusCode': 200,
            'body': json.dumps(f'{body}')
            }
    except Exception as e:
        return {
            'statusCode': 400,
            'body': json.dumps(f'{e}')
            }

