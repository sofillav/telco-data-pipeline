# Gold Layer Report

This report contains the business insights extracted from the processed data in the Gold layer.

---

## 1. What is the average revenue per user (ARPU) by plan type?

ARPU is calculated as the average of `monthly_bill_usd` per plan type. The values across plan types very are similar.

| Plan Type | Average Revenue (USD) |
|-----------|----------------------:|
| prepago   |                 79.50 |
| pospago   |                 78.51 |
| control   |                 78.14 |



---

## 2. What is the revenue distribution by geographic location?

Revenue is grouped by country using the sum of `monthly_bill_usd`. The table below shows total revenue and each country's share of the overall revenue.

| Country | Total Revenue (USD) | Revenue Percentage (%) |
|---------|--------------------:|----------------------:|
| COL     |           211,841.89 |                 55.25 |
| PER     |            57,102.45 |                 14.89 |
| ARG     |            48,516.23 |                 12.65 |
| MEX     |            40,592.96 |                 10.59 |
| CHL     |            25,361.70 |                  6.61 |


Colombia dominates the revenue share, contributing over 55% of the total revenue. Peru and Argentina follow, but with significantly smaller shares. This results could guide marketing strategies or suggest where to prioritize infrastructure and customer retention efforts.

---

## 3. Which customer segments generate the highest revenue?

We segment customers by plan type, age group, and credit score group, and aggregate total monthly revenue (`monthly_bill_usd`) to identify the most valuable segments.

| Plan Type | Total Revenue (USD) | Revenue Percentage (%) |
|-----------|--------------------:|----------------------:|
| control   |          128,547.07 |                 33.53 |
| prepago   |          128,066.80 |                 33.40 |
| pospago   |          126,801.36 |                 33.07 |


Revenue is evenly distributed across plan types, with each contributing roughly a third of total revenue. This suggests all plan types are economically significant, and customer acquisition or retention efforts should not focus on a single plan exclusively.

| Age Group | Total Revenue (USD) | Revenue Percentage (%) |
|-----------|--------------------:|----------------------:|
| Adult     |          177,613.43 |                 46.32 |
| Senior    |          125,264.84 |                 32.67 |
| Young     |           72,433.31 |                 18.89 |
| Unknown   |            8,103.65 |                  2.11 |


Adults (ages 36–60) are the most valuable age segment, generating nearly half the total revenue. Seniors (60+) also contribute a large share, while Young customers (18–35) represent under 20%.

| Credit Score Group | Total Revenue (USD) | Revenue Percentage (%) |
|--------------------|--------------------:|----------------------:|
| Very Good          |             42,829.49 |                 11.17 |
| Unknown            |              3,501.28 |                  0.91 |
| Poor               |            185,826.01 |                 48.47 |
| Good               |             48,222.04 |                 12.58 |
| Fair               |             66,265.48 |                 17.28 |
| Excellent          |             36,770.93 |                  9.59 |


Customers with poor credit scores contribute nearly half of the total revenue. This may indicate higher spending or a larger volume of such customers (probably the second one).

---

## 4. What is the distribution of customers by location?

We group customers by country to understand regional distribution.

Colombia accounts for more than half of the customer base, indicating it is the largest market in the dataset. Peru and Argentina follow, but with significantly smaller shares. These proportions can guide region-specific strategies or marketing focus.

| Country | Total Customers | Percentage (%) |
|---------|----------------:|---------------:|
| COL     |            2,747 |          54.94 |
| PER     |              739 |          14.78 |
| ARG     |              638 |          12.76 |
| MEX     |              524 |          10.48 |
| CHL     |              352 |           7.04 |


---

## 5. What is the age distribution of customers by plan type?

Across all plan types, the majority of customers fall into the Adult age group (44%–46%), followed by the Senior group (32%–35%). The Young group accounts for around 18%–19%.

The customer base for all plan types is quite similar in age structure, indicating no significant age-based preference for a specific plan.

The relatively high proportion of Seniors suggests that these mobile plans works well to older adults, which could influence marketing or service design.

| Plan Type | Age Group | Total Customers | Percentage (%) |
|-----------|-----------|----------------:|---------------:|
| control   | Adult     |             754 |          44.62 |
| control   | Senior    |             569 |          33.67 |
| control   | Young     |             321 |          18.99 |
| control   | Unknown   |              46 |           2.72 |


| Plan Type | Age Group | Total Customers | Percentage (%) |
|-----------|-----------|----------------:|---------------:|
| pospago   | Adult     |             776 |          46.89 |
| pospago   | Senior    |             535 |          32.33 |
| pospago   | Young     |             300 |          18.13 |
| pospago   | Unknown   |              44 |           2.66 |



| Plan Type | Age Group | Total Customers | Percentage (%) |
|-----------|-----------|----------------:|---------------:|
| prepago   | Adult     |             750 |          45.32 |
| prepago   | Senior    |             577 |          34.86 |
| prepago   | Young     |             303 |          18.31 |
| prepago   | Unknown   |              25 |           1.51 |




---

## 6. What is the age distribution by country and operator?

| Country | Operator | Age Group | Total Customers |
|---------|----------|-----------|----------------:|
| ARG     | Claro    | Adult     |              71 |
| ARG     | Claro    | Senior    |              59 |
| ARG     | Claro    | Young     |              32 |
| ARG     | Movistar | Adult     |              73 |
| ARG     | Movistar | Senior    |              45 |
| ARG     | Movistar | Young     |              26 |
| ARG     | Tigo     | Adult     |              75 |
| ARG     | Tigo     | Senior    |              52 |
| ARG     | Tigo     | Young     |              33 |
| ARG     | WOM      | Adult     |              82 |
| ARG     | WOM      | Senior    |              51 |
| ARG     | WOM      | Young     |              27 |



| Country | Operator | Age Group | Total Customers |
|---------|----------|-----------|----------------:|
| CHL     | Claro    | Adult     |              41 |
| CHL     | Claro    | Senior    |              28 |
| CHL     | Claro    | Young     |              14 |
| CHL     | Movistar | Adult     |              31 |
| CHL     | Movistar | Senior    |              31 |
| CHL     | Movistar | Young     |              20 |
| CHL     | Tigo     | Adult     |              37 |
| CHL     | Tigo     | Senior    |              33 |
| CHL     | Tigo     | Young     |              17 |
| CHL     | WOM      | Adult     |              44 |
| CHL     | WOM      | Senior    |              33 |
| CHL     | WOM      | Young     |              13 |


| Country | Operator | Age Group | Total Customers |
|---------|----------|-----------|----------------:|
| COL     | Claro    | Adult     |             305 |
| COL     | Claro    | Senior    |             240 |
| COL     | Claro    | Young     |             139 |
| COL     | Movistar | Adult     |             314 |
| COL     | Movistar | Senior    |             218 |
| COL     | Movistar | Young     |             117 |
| COL     | Tigo     | Adult     |             343 |
| COL     | Tigo     | Senior    |             220 |
| COL     | Tigo     | Young     |             119 |
| COL     | WOM      | Adult     |             285 |
| COL     | WOM      | Senior    |             249 |
| COL     | WOM      | Young     |             140 |


| Country | Operator | Age Group | Total Customers |
|---------|----------|-----------|----------------:|
| MEX     | Claro    | Adult     |              70 |
| MEX     | Claro    | Senior    |              43 |
| MEX     | Claro    | Young     |              18 |
| MEX     | Movistar | Adult     |              52 |
| MEX     | Movistar | Senior    |              36 |
| MEX     | Movistar | Young     |              20 |
| MEX     | Tigo     | Adult     |              57 |
| MEX     | Tigo     | Senior    |              53 |
| MEX     | Tigo     | Young     |              27 |
| MEX     | WOM      | Adult     |              64 |
| MEX     | WOM      | Senior    |              41 |
| MEX     | WOM      | Young     |              29 |


| Country | Operator | Age Group | Total Customers |
|---------|----------|-----------|----------------:|
| PER     | Claro    | Adult     |              94 |
| PER     | Claro    | Senior    |              60 |
| PER     | Claro    | Young     |              36 |
| PER     | Movistar | Senior    |              72 |
| PER     | Movistar | Adult     |              70 |
| PER     | Movistar | Young     |              34 |
| PER     | Tigo     | Adult     |              87 |
| PER     | Tigo     | Senior    |              51 |
| PER     | Tigo     | Young     |              32 |
| PER     | WOM      | Adult     |              85 |
| PER     | WOM      | Senior    |              66 |
| PER     | WOM      | Young     |              31 |



---

## 7. How are customers distributed across different operators?

The customer base is almost evenly split among the four main operators.  The market appears competitive and balanced, with no single operator dominating. This suggests that customers have relatively equal preferences or access across these providers, potentially increasing the importance of service differentiation and customer experience for gaining market share.

| Operator | Total Customers | Percentage |
|----------|-----------------|------------|
| Claro    |            1280 |      25.60 |
| WOM      |            1267 |      25.34 |
| Tigo     |            1262 |      25.24 |
| Movistar |            1191 |      23.82 |




---

## 8. What is customer segmentation by credit score ranges?

Nearly half of the customers fall into the "Poor" credit score group. The remaining customers are more evenly distributed across better credit score categories. This distribution can guide risk management and marketing strategies tailored to different credit profiles.

| Credit Score Group | Total Customers | Percentage |
|--------------------|-----------------|------------|
| Poor               |            2373 |      48.72 |
| Fair               |             828 |      17.00 |
| Good               |             600 |      12.32 |
| Very Good          |             550 |      11.29 |
| Excellent          |             477 |       9.79 |
| Unknown            |              43 |       0.88 |


---

## 9. What are the most popular device brands?

| Device Brand | Total Customers | Percentage |
|--------------|-----------------|------------|
| Samsung      |            1260 |      25.20 |
| Xiaomi       |            1250 |      25.00 |
| Apple        |            1246 |      24.92 |
| HUAWEI       |            1244 |      24.88 |


This balanced distribution suggests no single brand dominates the market, indicating diverse device preferences across the user base.

---

## 10. What is device brand preference by country/operator?

country | operator | device_brand | total_customers | percentage 

---------+----------+--------------+-----------------+------------

 ARG     | Claro    | Xiaomi       |              44 |      26.99

 ARG     | Claro    | Apple        |              44 |      26.99

 ARG     | Claro    | HUAWEI       |              44 |      26.99

 ARG     | Claro    | Samsung      |              31 |      19.02

 ARG     | Movistar | Apple        |              45 |      30.61

 ARG     | Movistar | Xiaomi       |              39 |      26.53

 ARG     | Movistar | Samsung      |              36 |      24.49

 ARG     | Movistar | HUAWEI       |              27 |      18.37

 ARG     | Tigo     | Xiaomi       |              48 |      29.27

 ARG     | Tigo     | HUAWEI       |              43 |      26.22

 ARG     | Tigo     | Apple        |              37 |      22.56

 ARG     | Tigo     | Samsung      |              36 |      21.95

 ARG     | WOM      | Xiaomi       |              48 |      29.27

 ARG     | WOM      | HUAWEI       |              41 |      25.00


 ARG     | WOM      | Apple        |              40 |      24.39

 ARG     | WOM      | Samsung      |              35 |      21.34

country | operator | device_brand | total_customers | percentage 

---------+----------+--------------+-----------------+------------

 CHL     | Claro    | Apple        |              24 |      27.59

 CHL     | Claro    | Xiaomi       |              24 |      27.59

 CHL     | Claro    | HUAWEI       |              22 |      25.29

 CHL     | Claro    | Samsung      |              17 |      19.54

 CHL     | Movistar | Samsung      |              24 |      28.24

 CHL     | Movistar | Xiaomi       |              23 |      27.06

 CHL     | Movistar | HUAWEI       |              20 |      23.53

 CHL     | Movistar | Apple        |              18 |      21.18

 CHL     | Tigo     | Xiaomi       |              26 |      29.21

 CHL     | Tigo     | HUAWEI       |              22 |      24.72

 CHL     | Tigo     | Samsung      |              21 |      23.60

 CHL     | Tigo     | Apple        |              20 |      22.47

 CHL     | WOM      | HUAWEI       |              26 |      28.57

 CHL     | WOM      | Apple        |              25 |      27.47

 CHL     | WOM      | Samsung      |              25 |      27.47

 CHL     | WOM      | Xiaomi       |              15 |      16.48

country | operator | device_brand | total_customers | percentage 

---------+----------+--------------+-----------------+------------

 COL     | Claro    | HUAWEI       |             190 |      27.10

 COL     | Claro    | Samsung      |             176 |      25.11

 COL     | Claro    | Apple        |             170 |      24.25

 COL     | Claro    | Xiaomi       |             165 |      23.54

 COL     | Movistar | Samsung      |             172 |      25.79

 COL     | Movistar | HUAWEI       |             169 |      25.34

 COL     | Movistar | Apple        |             165 |      24.74

 COL     | Movistar | Xiaomi       |             161 |      24.14

 COL     | Tigo     | Samsung      |             181 |      26.12

 COL     | Tigo     | HUAWEI       |             177 |      25.54

 COL     | Tigo     | Xiaomi       |             176 |      25.40

 COL     | Tigo     | Apple        |             159 |      22.94

 COL     | WOM      | Samsung      |             189 |      27.55

 COL     | WOM      | Xiaomi       |             183 |      26.68


 COL     | WOM      | Apple        |             174 |      25.36

 COL     | WOM      | HUAWEI       |             140 |      20.41

country | operator | device_brand | total_customers | percentage 

---------+----------+--------------+-----------------+------------

 MEX     | Claro    | Samsung      |              37 |      27.41

 MEX     | Claro    | Apple        |              36 |      26.67

 MEX     | Claro    | HUAWEI       |              36 |      26.67

 MEX     | Claro    | Xiaomi       |              26 |      19.26

 MEX     | Movistar | Samsung      |              32 |      29.36

 MEX     | Movistar | HUAWEI       |              31 |      28.44

 MEX     | Movistar | Apple        |              27 |      24.77

 MEX     | Movistar | Xiaomi       |              19 |      17.43

 MEX     | Tigo     | Xiaomi       |              37 |      26.43

 MEX     | Tigo     | Apple        |              36 |      25.71

 MEX     | Tigo     | Samsung      |              36 |      25.71

 MEX     | Tigo     | HUAWEI       |              31 |      22.14

 MEX     | WOM      | Xiaomi       |              40 |      28.57

 MEX     | WOM      | Samsung      |              37 |      26.43

 MEX     | WOM      | Apple        |              36 |      25.71

 MEX     | WOM      | HUAWEI       |              27 |      19.29

country | operator | device_brand | total_customers | percentage 

---------+----------+--------------+-----------------+------------

 PER     | Claro    | Apple        |              51 |      26.29

 PER     | Claro    | HUAWEI       |              50 |      25.77

 PER     | Claro    | Xiaomi       |              49 |      25.26

 PER     | Claro    | Samsung      |              44 |      22.68

 PER     | Movistar | Xiaomi       |              52 |      28.42
 
 PER     | Movistar | Apple        |              47 |      25.68

 PER     | Movistar | HUAWEI       |              46 |      25.14

 PER     | Movistar | Samsung      |              38 |      20.77

 PER     | Tigo     | Apple        |              51 |      28.98

 PER     | Tigo     | Xiaomi       |              43 |      24.43

 PER     | Tigo     | HUAWEI       |              42 |      23.86

 PER     | Tigo     | Samsung      |              40 |      22.73


 PER     | WOM      | HUAWEI       |              60 |      32.26

 PER     | WOM      | Samsung      |              53 |      28.49

 PER     | WOM      | Apple        |              41 |      22.04

 PER     | WOM      | Xiaomi       |              32 |      17.20

---

## 11. What is device brand preference by plan type?

Device brand preferences are almost evenly distributed across all plan types.

| Plan Type | Device Brand | Total Customers | Percentage |
|-----------|--------------|-----------------|------------|
| control   | Samsung      |             433 |      25.62 |
| control   | HUAWEI       |             432 |      25.56 |
| control   | Xiaomi       |             428 |      25.33 |
| control   | Apple        |             397 |      23.49 |




| Plan Type | Device Brand | Total Customers | Percentage |
|-----------|--------------|-----------------|------------|
| pospago   | Apple        |             432 |      26.10 |
| pospago   | HUAWEI       |             414 |      25.02 |
| pospago   | Xiaomi       |             406 |      24.53 |
| pospago   | Samsung      |             403 |      24.35 |




| Plan Type | Device Brand | Total Customers | Percentage |
|-----------|--------------|-----------------|------------|
| prepago   | Samsung      |             424 |      25.62 |
| prepago   | Apple        |             417 |      25.20 |
| prepago   | Xiaomi       |             416 |      25.14 |
| prepago   | HUAWEI       |             398 |      24.05 |



## 12. Which services are most commonly contracted?

The five service types are almost equally popular, each being contracted by about 20% of the service entries. This could suggests that customers tend to subscribe to multiple services rather than favoring just one.

    service    | total_customers | percentage 

---------------+-----------------+------------

 INTERNATIONAL |            2389 |      20.26

 VOICE         |            2364 |      20.05

 SMS           |            2350 |      19.93

 DATA          |            2348 |      19.91

 ROAMING       |            2341 |      19.85

---

## 13. What service combinations are most popular?

Single-service contracts like `ROAMING` and `INTERNATIONAL` are quite common, but full service bundles such as `DATA,INTERNATIONAL,SMS,VOICE` are almost equally popular

       service_combination        | total_customers | percentage 

----------------------------------+-----------------+------------

 ROAMING                          |             263 |       5.55

 INTERNATIONAL                    |             260 |       5.48
 
 SMS                              |             240 |       5.06

 DATA,INTERNATIONAL,ROAMING,VOICE |             239 |       5.04

 DATA,INTERNATIONAL,SMS,VOICE     |             236 |       4.98

 DATA,ROAMING,SMS,VOICE           |             236 |       4.98

 INTERNATIONAL,ROAMING,SMS,VOICE  |             230 |       4.85

 DATA                             |             220 |       4.64

 VOICE                            |             219 |       4.62
 
 DATA,INTERNATIONAL,ROAMING,SMS   |             215 |       4.53

 INTERNATIONAL,SMS,VOICE          |             134 |       2.83

 DATA,INTERNATIONAL,SMS           |             132 |       2.78

 INTERNATIONAL,ROAMING            |             130 |       2.74

 INTERNATIONAL,VOICE              |             128 |       2.70

 DATA,INTERNATIONAL,VOICE         |             128 |       2.70

 DATA,ROAMING                     |             125 |       2.64
 
 DATA,SMS                         |             125 |       2.64

 INTERNATIONAL,ROAMING,VOICE      |             123 |       2.59

 DATA,SMS,VOICE                   |             123 |       2.59

 DATA,ROAMING,SMS                 |             122 |       2.57

 INTERNATIONAL,SMS                |             120 |       2.53

 DATA,VOICE                       |             117 |       2.47

 SMS,VOICE                        |             116 |       2.45
 
 DATA,INTERNATIONAL,ROAMING       |             114 |       2.40

 DATA,ROAMING,VOICE               |             113 |       2.38

 ROAMING,SMS,VOICE                |             112 |       2.36

 ROAMING,SMS                      |             112 |       2.36

 ROAMING,VOICE                    |             110 |       2.32

 DATA,INTERNATIONAL               |             103 |       2.17

 INTERNATIONAL,ROAMING,SMS        |              97 |       2.05




## 14. What percentage of customers have payment issues?



---

## 15. Which customers have pending payments?



---

## 16. How does credit score correlate with payment behavior?



---

## 17. How does the distribution of new customers change over time?



---

## 18. How does the distribution of new customers change over time?

---

## 19. What are customer acquisition trends by operator?



---

## 20. What percentage of customers are active/suspended/inactive?

---

## 21. Which service combinations drive highest revenue?

---

## 22. How do the mean and median monthly revenues per user compare across different plan types and operators?



