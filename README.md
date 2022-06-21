# I. Project Overview
This repository apply SQL to analyze dataset which generated from an autonomous bank marketing campaign,which convince customer to agree to terms deposit, and find key insight to develop a more effective strategy for future campaign. 

Key questions should be addressed:
1. Who are more willing to accept term deposit? Build Customer Profiles who are more likely to make term deposit 
2. How many call attemps should we make to convince customer? 
3. For retargeting customers from previous campaign, what is the successful rate ?

# II. Dataset explaination for initial understanding
- Data described the results from the marketing campaign of financial institutions whether the customers agreed to subscribe to a bank term deposit or not.
- The campaign conducted and recorded by telesales team. 
- The range of records included: customers' profiles which are ages, occupation & marital status, bank balance, housing and loan status, education background. Data from the previous marketing campaign is also included: customers who have not yet called, number of contact from the previous campaign and whether the past campaign was successful or not. 
Datasource: https://www.kaggle.com/datasets/janiobachmann/bank-marketing-dataset

# III. Data field explaination 
Datasets are break down into 3 areas for better understanding: 
-  **Customer Profile** - (age - job - marital - education). When analyzing marketing campaigns, this should take into consideration to find a similar pattern for those customers who agreed to sign up for term deposit
- **Financial Status**: Yearly Balance, housing and loan status are also critical to understand whether the customer has sufficient funds to make terms deposit
- **The Status of the call** (call duration - number of time contacted - number of time re-contacted, call result) could be considered to analyze to find similarity of the call duration both successful and failed  
- Some data field will be modified,dropped and rennamed during data cleaning phase

#  IV. Project Phase
- Phase 1: Inspect data
- Phase 2: clean Data
- Phase 3: Build customer profile and make recommendation
      - Understand and Build customer profiles marketing campaign such as customer demographic, financial status ,retargeting attempts. 
   



