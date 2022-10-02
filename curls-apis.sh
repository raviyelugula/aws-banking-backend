curl --location --request POST 'https://pmel4d4id8.execute-api.us-west-1.amazonaws.com/Dev/api-gateway/create_customer' \
--header 'Content-Type: application/json' \
--data-raw '{
  "ssn": "11112222334",
  "dob": "2022-09-23",
  "first_name": "satish",
  "last_name": "G",
  "phone": "89898988989",
  "email": "ehjkhk,hjkh@gmail.com",
  "customer_address": "abc, def, ghk, iio, 2003"
}'
 
curl --location --request GET 'https://pmel4d4id8.execute-api.us-west-1.amazonaws.com/Dev/api-gateway/get_customer_by_id' \
--header 'Content-Type: application/json' \
--data-raw '{
  "customer_id": "16"
}'

curl --location --request POST 'https://pmel4d4id8.execute-api.us-west-1.amazonaws.com/Dev/api-gateway/create_kyc' \
--header 'Content-Type: application/json' \
--data-raw '{
  "ssn":"12345678901", 
  "phone":"+1 8912 9090", 
  "email":"abc@gmail.com", 
  "kyc_status":"created", 
  "comments":"pending for validation", 
  "customer_id":16
}'

