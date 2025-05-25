# ZATX Customer Inventory Management System

## Project Overview
In this project, you will create a database system for ZATX, a company that manages 
chemical storage terminals. Chemical companies use ZATX's tanks to store their 
products, and ZATX provides services for filling tanks and loading products onto 
trucks. Your task is to implement a MySQL database that will track customers, tanks, 
contracts, and transactions.

## Key Learnings
- Create database tables with appropriate constraints
- Implement relationships between tables using foreign keys
- Write and execute INSERT statements to populate tables
- Create stored procedures to handle business logic
- Implement triggers for automated database actions
- Write SQL queries to generate reports

## Database Structure
 database will consist of 8 tables:
- 4 master tables (setup once with fixed data)
- transaction tables (for recording operations)
- 1 log table (for tracking all transactions)

## Master Tables 
1. ci_company - Company information 
2. ci_operation - Types of operations and their charges 
3. ci_customer - Customer information 
4. ci_TANK - Tank information

## Transaction Tables
5. ci_CONTRACT - Contracts between customers and ZATX 
6. ci_tankfill - Records of tank filling operations 
7. ci_truckload - Records of truck loading operations

## Log Table 
8. ci_tranlog - Transaction log for all operations

##  Stored Procedures 
1. add_new_contract - Create a new contract between a customer and ZATX 
- Validate customer and tank existence
- Ensure tank is available (not already contracted)
- Verify start date is within allowed range
- Calculate end date based on duration
- Update tank status to contracted 
2. fill_tank - Record a tank filling operation
  - Verify active contract exists for customer and tank
  Validate transaction date
  - Check if quantity doesn't exceed tank threshold
  - Record transaction and update tank balance 
3. TruckEntry - Record truck arrival for loading 
  - Validate contract, date, and truck information
  - Record entry weight (empty truck) 
4. TruckExit - Complete truck loading process  
- Find pending truck entry record
- Calculate net weight (product loaded)
- Update tank balance
- Log the transaction

