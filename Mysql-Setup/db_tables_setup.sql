use mysql;

create table Customer (
    customer_id int AUTO_INCREMENT primary key,
    ssn varchar(11) not null,
    dob date not null,
    first_name varchar(40) not null,
    last_name varchar(40) not null,
    phone varchar(15) not null,
    email varchar(30) not null,
    customer_address varchar(200) not null
);

create table KYC(
    program_id BIGINT AUTO_INCREMENT not null primary key,
    ssn varchar(11) UNIQUE not null,
    phone varchar(15) not null,
    email varchar(30) not null,
    kyc_status varchar(15) not null,
    comments varchar(200) not null,
    customer_id int not null,
    FOREIGN KEY (`customer_id`) REFERENCES `Customer` (`customer_id`) ON DELETE CASCADE
);
ALTER TABLE KYC AUTO_INCREMENT = 100000;

create table Account (
    account_number BIGINT AUTO_INCREMENT not null primary key,
    program_id BIGINT not null ,
    customer_id int not null ,
    account_status varchar(10) not null,
    account_type varchar(10) not null,
    date_uploaded date not null,
    date_created date not null,
    FOREIGN KEY (`program_id`) REFERENCES `KYC` (`program_id`) ON DELETE CASCADE
);
ALTER TABLE Account AUTO_INCREMENT = 1000900100;

create table Cards (
    card_number BIGINT AUTO_INCREMENT not null primary key,
    account_number BIGINT not null,
    FOREIGN KEY (`account_number`) REFERENCES `Account` (`account_number`) ON DELETE CASCADE
);
ALTER TABLE Cards AUTO_INCREMENT = 5000999955554444;

create table Balance (
    card_number BIGINT not null ,
    prev_amount double(20,4) not null,
    curr_amount double(20,4) not null,
    currency varchar(10),
    FOREIGN KEY (`card_number`) REFERENCES `Cards` (`card_number`) ON DELETE CASCADE
);

create table Transactions (
    card_number BIGINT not null, 
    prev_amount double(20,4) not null,
    curr_amount double(20,4) not null,
    trans_amount int AUTO_INCREMENT not null primary key,
    FOREIGN KEY (`card_number`) REFERENCES `Cards` (`card_number`) ON DELETE CASCADE
);
