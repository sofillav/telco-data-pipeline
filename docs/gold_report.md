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

The table was obtained with the following query:

```sql
select 
	plan_type, 
	round(avg(monthly_bill_usd),2) as average_revenue_usd
from public_gold.gold_customer_revenue_metrics
group by plan_type
order by average_revenue_usd desc;
```


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

The table was obtained with the following query:

```sql
select 
	country, 
	round(sum(monthly_bill_usd), 2) as total_revenue_usd,
    round(100.0 * sum(monthly_bill_usd) / sum(sum(monthly_bill_usd)) over (), 2) as revenue_percentage
from public_gold.gold_customer_revenue_metrics
group by country
order by total_revenue_usd desc;
```

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

The table was obtained with the following query:

```sql
select 
    country,
    count(customer_sk) as total_customers,
    round(100.0 * count(customer_sk) / sum(count(customer_sk)) over (), 2) as percentage
from public_gold.gold_customer_demographics
group by country
order by total_customers desc;
```

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

Argentina:

| Country | Operator | Age Group | Total Customers |
|---------|----------|-----------|----------------:|
| ARG     | Claro    | Adult     |              71 |
| ARG     | Claro    | Senior    |              59 |
| ARG     | Claro    | Young     |              32 |

| Country | Operator | Age Group | Total Customers |
|---------|----------|-----------|----------------:|
| ARG     | Movistar | Adult     |              73 |
| ARG     | Movistar | Senior    |              45 |
| ARG     | Movistar | Young     |              26 |

| Country | Operator | Age Group | Total Customers |
|---------|----------|-----------|----------------:|
| ARG     | Tigo     | Adult     |              75 |
| ARG     | Tigo     | Senior    |              52 |
| ARG     | Tigo     | Young     |              33 |

| Country | Operator | Age Group | Total Customers |
|---------|----------|-----------|----------------:|
| ARG     | WOM      | Adult     |              82 |
| ARG     | WOM      | Senior    |              51 |
| ARG     | WOM      | Young     |              27 |

Chile:

| Country | Operator | Age Group | Total Customers |
|---------|----------|-----------|----------------:|
| CHL     | Claro    | Adult     |              41 |
| CHL     | Claro    | Senior    |              28 |
| CHL     | Claro    | Young     |              14 |

| Country | Operator | Age Group | Total Customers |
|---------|----------|-----------|----------------:|
| CHL     | Movistar | Adult     |              31 |
| CHL     | Movistar | Senior    |              31 |
| CHL     | Movistar | Young     |              20 |

| Country | Operator | Age Group | Total Customers |
|---------|----------|-----------|----------------:|
| CHL     | Tigo     | Adult     |              37 |
| CHL     | Tigo     | Senior    |              33 |
| CHL     | Tigo     | Young     |              17 |

| Country | Operator | Age Group | Total Customers |
|---------|----------|-----------|----------------:|
| CHL     | WOM      | Adult     |              44 |
| CHL     | WOM      | Senior    |              33 |
| CHL     | WOM      | Young     |              13 |

Colombia:

| Country | Operator | Age Group | Total Customers |
|---------|----------|-----------|----------------:|
| COL     | Claro    | Adult     |             305 |
| COL     | Claro    | Senior    |             240 |
| COL     | Claro    | Young     |             139 |

| Country | Operator | Age Group | Total Customers |
|---------|----------|-----------|----------------:|
| COL     | Movistar | Adult     |             314 |
| COL     | Movistar | Senior    |             218 |
| COL     | Movistar | Young     |             117 |

| Country | Operator | Age Group | Total Customers |
|---------|----------|-----------|----------------:|
| COL     | Tigo     | Adult     |             343 |
| COL     | Tigo     | Senior    |             220 |
| COL     | Tigo     | Young     |             119 |

| Country | Operator | Age Group | Total Customers |
|---------|----------|-----------|----------------:|
| COL     | WOM      | Adult     |             285 |
| COL     | WOM      | Senior    |             249 |
| COL     | WOM      | Young     |             140 |

Mexico:

| Country | Operator | Age Group | Total Customers |
|---------|----------|-----------|----------------:|
| MEX     | Claro    | Adult     |              70 |
| MEX     | Claro    | Senior    |              43 |
| MEX     | Claro    | Young     |              18 |

| Country | Operator | Age Group | Total Customers |
|---------|----------|-----------|----------------:|
| MEX     | Movistar | Adult     |              52 |
| MEX     | Movistar | Senior    |              36 |
| MEX     | Movistar | Young     |              20 |

| Country | Operator | Age Group | Total Customers |
|---------|----------|-----------|----------------:|
| MEX     | Tigo     | Adult     |              57 |
| MEX     | Tigo     | Senior    |              53 |
| MEX     | Tigo     | Young     |              27 |

| Country | Operator | Age Group | Total Customers |
|---------|----------|-----------|----------------:|
| MEX     | WOM      | Adult     |              64 |
| MEX     | WOM      | Senior    |              41 |
| MEX     | WOM      | Young     |              29 |

Peru:

| Country | Operator | Age Group | Total Customers |
|---------|----------|-----------|----------------:|
| PER     | Claro    | Adult     |              94 |
| PER     | Claro    | Senior    |              60 |
| PER     | Claro    | Young     |              36 |

| Country | Operator | Age Group | Total Customers |
|---------|----------|-----------|----------------:|
| PER     | Movistar | Senior    |              72 |
| PER     | Movistar | Adult     |              70 |
| PER     | Movistar | Young     |              34 |

| Country | Operator | Age Group | Total Customers |
|---------|----------|-----------|----------------:|
| PER     | Tigo     | Adult     |              87 |
| PER     | Tigo     | Senior    |              51 |
| PER     | Tigo     | Young     |              32 |

| Country | Operator | Age Group | Total Customers |
|---------|----------|-----------|----------------:|
| PER     | WOM      | Adult     |              85 |
| PER     | WOM      | Senior    |              66 |
| PER     | WOM      | Young     |              31 |

These tables was obtained with the following query:

```sql
select
    country,
	operator,
    age_group,
    count(*) as total_customers
from public_gold.gold_customer_demographics
where age_group != 'Unknown'
group by country, operator, age_group
order by country, operator, total_customers desc;
```


---

## 7. How are customers distributed across different operators?

The customer base is almost evenly split among the four main operators.  The market appears competitive and balanced, with no single operator dominating. This suggests that customers have relatively equal preferences or access across these providers. This shows importance of service differentiation and customer experience for gaining market share.

| Operator | Total Customers | Percentage |
|----------|-----------------|------------|
| Claro    |            1280 |      25.60 |
| WOM      |            1267 |      25.34 |
| Tigo     |            1262 |      25.24 |
| Movistar |            1191 |      23.82 |


The table was obtained with the following query:

```sql
select
    operator,
    count(*) as total_customers,
    round(100.0 * count(*) / sum(count(*)) over (), 2) as percentage
from public_gold.gold_customer_demographics
group by operator
order by total_customers desc;
```


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

The table was obtained with the following query:

```sql
select
    credit_score_group,
    count(*) as total_customers,
    round(100.0 * count(*) / sum(count(*)) over (), 2) as percentage
from public_gold.gold_customer_revenue_metrics
group by credit_score_group
order by total_customers desc;
```

---

## 9. What are the most popular device brands?

This balanced distribution suggests no single brand dominates the market, indicating diverse device preferences across the user base.

| Device Brand | Total Customers | Percentage |
|--------------|-----------------|------------|
| Samsung      |            1260 |      25.20 |
| Xiaomi       |            1250 |      25.00 |
| Apple        |            1246 |      24.92 |
| HUAWEI       |            1244 |      24.88 |


The table was obtained with the following query:

```sql

```
---

## 10. What is device brand preference by country/operator?

Argentina:

| Country | Operator | Device Brand | Total Customers | Percentage (%) |
|---------|----------|--------------|------------------|----------------|
| ARG     | Claro    | Xiaomi       | 44               | 26.99          |
| ARG     | Claro    | Apple        | 44               | 26.99          |
| ARG     | Claro    | HUAWEI       | 44               | 26.99          |
| ARG     | Claro    | Samsung      | 31               | 19.02          |

| Country | Operator | Device Brand | Total Customers | Percentage (%) |
|---------|----------|--------------|------------------|----------------|
| ARG     | Movistar | Apple        | 45               | 30.61          |
| ARG     | Movistar | Xiaomi       | 39               | 26.53          |
| ARG     | Movistar | Samsung      | 36               | 24.49          |
| ARG     | Movistar | HUAWEI       | 27               | 18.37          |

| Country | Operator | Device Brand | Total Customers | Percentage (%) |
|---------|----------|--------------|------------------|----------------|
| ARG     | Tigo     | Xiaomi       | 48               | 29.27          |
| ARG     | Tigo     | HUAWEI       | 43               | 26.22          |
| ARG     | Tigo     | Apple        | 37               | 22.56          |
| ARG     | Tigo     | Samsung      | 36               | 21.95          |

| Country | Operator | Device Brand | Total Customers | Percentage (%) |
|---------|----------|--------------|------------------|----------------|
| ARG     | WOM      | Xiaomi       | 48               | 29.27          |
| ARG     | WOM      | HUAWEI       | 41               | 25.00          |
| ARG     | WOM      | Apple        | 40               | 24.39          |
| ARG     | WOM      | Samsung      | 35               | 21.34          |

Chile:

| Country | Operator | Device Brand | Total Customers | Percentage (%) |
|---------|----------|--------------|------------------|----------------|
| CHL     | Claro    | Apple        | 24               | 27.59          |
| CHL     | Claro    | Xiaomi       | 24               | 27.59          |
| CHL     | Claro    | HUAWEI       | 22               | 25.29          |
| CHL     | Claro    | Samsung      | 17               | 19.54          |

| Country | Operator | Device Brand | Total Customers | Percentage (%) |
|---------|----------|--------------|------------------|----------------|
| CHL     | Movistar | Samsung      | 24               | 28.24          |
| CHL     | Movistar | Xiaomi       | 23               | 27.06          |
| CHL     | Movistar | HUAWEI       | 20               | 23.53          |
| CHL     | Movistar | Apple        | 18               | 21.18          |

| Country | Operator | Device Brand | Total Customers | Percentage (%) |
|---------|----------|--------------|------------------|----------------|
| CHL     | Tigo     | Xiaomi       | 26               | 29.21          |
| CHL     | Tigo     | HUAWEI       | 22               | 24.72          |
| CHL     | Tigo     | Samsung      | 21               | 23.60          |
| CHL     | Tigo     | Apple        | 20               | 22.47          |

| Country | Operator | Device Brand | Total Customers | Percentage (%) |
|---------|----------|--------------|------------------|----------------|
| CHL     | WOM      | HUAWEI       | 26               | 28.57          |
| CHL     | WOM      | Apple        | 25               | 27.47          |
| CHL     | WOM      | Samsung      | 25               | 27.47          |
| CHL     | WOM      | Xiaomi       | 15               | 16.48          |

Colombia:

| Country | Operator | Device Brand | Total Customers | Percentage (%) |
|---------|----------|--------------|------------------|----------------|
| COL     | Claro    | HUAWEI       | 190              | 27.10          |
| COL     | Claro    | Samsung      | 176              | 25.11          |
| COL     | Claro    | Apple        | 170              | 24.25          |
| COL     | Claro    | Xiaomi       | 165              | 23.54          |

| Country | Operator | Device Brand | Total Customers | Percentage (%) |
|---------|----------|--------------|------------------|----------------|
| COL     | Movistar | Samsung      | 172              | 25.79          |
| COL     | Movistar | HUAWEI       | 169              | 25.34          |
| COL     | Movistar | Apple        | 165              | 24.74          |
| COL     | Movistar | Xiaomi       | 161              | 24.14          |

| Country | Operator | Device Brand | Total Customers | Percentage (%) |
|---------|----------|--------------|------------------|----------------|
| COL     | Tigo     | Samsung      | 181              | 26.12          |
| COL     | Tigo     | HUAWEI       | 177              | 25.54          |
| COL     | Tigo     | Xiaomi       | 176              | 25.40          |
| COL     | Tigo     | Apple        | 159              | 22.94          |

| Country | Operator | Device Brand | Total Customers | Percentage (%) |
|---------|----------|--------------|------------------|----------------|
| COL     | WOM      | Samsung      | 189              | 27.55          |
| COL     | WOM      | Xiaomi       | 183              | 26.68          |
| COL     | WOM      | Apple        | 174              | 25.36          |
| COL     | WOM      | HUAWEI       | 140              | 20.41          |

Mexico:

| Country | Operator | Device Brand | Total Customers | Percentage (%) |
|---------|----------|--------------|------------------|----------------|
| MEX     | Claro    | Samsung      | 37               | 27.41          |
| MEX     | Claro    | Apple        | 36               | 26.67          |
| MEX     | Claro    | HUAWEI       | 36               | 26.67          |
| MEX     | Claro    | Xiaomi       | 26               | 19.26          |

| Country | Operator | Device Brand | Total Customers | Percentage (%) |
|---------|----------|--------------|------------------|----------------|
| MEX     | Movistar | Samsung      | 32               | 29.36          |
| MEX     | Movistar | HUAWEI       | 31               | 28.44          |
| MEX     | Movistar | Apple        | 27               | 24.77          |
| MEX     | Movistar | Xiaomi       | 19               | 17.43          |

| Country | Operator | Device Brand | Total Customers | Percentage (%) |
|---------|----------|--------------|------------------|----------------|
| MEX     | Tigo     | Xiaomi       | 37               | 26.43          |
| MEX     | Tigo     | Apple        | 36               | 25.71          |
| MEX     | Tigo     | Samsung      | 36               | 25.71          |
| MEX     | Tigo     | HUAWEI       | 31               | 22.14          |

| Country | Operator | Device Brand | Total Customers | Percentage (%) |
|---------|----------|--------------|------------------|----------------|
| MEX     | WOM      | Xiaomi       | 40               | 28.57          |
| MEX     | WOM      | Samsung      | 37               | 26.43          |
| MEX     | WOM      | Apple        | 36               | 25.71          |
| MEX     | WOM      | HUAWEI       | 27               | 19.29          |

Peru:

| Country | Operator | Device Brand | Total Customers | Percentage (%) |
|---------|----------|--------------|------------------|----------------|
| PER     | Claro    | Apple        | 51               | 26.29          |
| PER     | Claro    | HUAWEI       | 50               | 25.77          |
| PER     | Claro    | Xiaomi       | 49               | 25.26          |
| PER     | Claro    | Samsung      | 44               | 22.68          |

| Country | Operator | Device Brand | Total Customers | Percentage (%) |
|---------|----------|--------------|------------------|----------------|
| PER     | Movistar | Xiaomi       | 52               | 28.42          |
| PER     | Movistar | Apple        | 47               | 25.68          |
| PER     | Movistar | HUAWEI       | 46               | 25.14          |
| PER     | Movistar | Samsung      | 38               | 20.77          |

| Country | Operator | Device Brand | Total Customers | Percentage (%) |
|---------|----------|--------------|------------------|----------------|
| PER     | Tigo     | Apple        | 51               | 28.98          |
| PER     | Tigo     | Xiaomi       | 43               | 24.43          |
| PER     | Tigo     | HUAWEI       | 42               | 23.86          |
| PER     | Tigo     | Samsung      | 40               | 22.73          |

| Country | Operator | Device Brand | Total Customers | Percentage (%) |
|---------|----------|--------------|------------------|----------------|
| PER     | WOM      | HUAWEI       | 60               | 32.26          |
| PER     | WOM      | Samsung      | 53               | 28.49          |
| PER     | WOM      | Apple        | 41               | 22.04          |
| PER     | WOM      | Xiaomi       | 32               | 17.20          |

These tables was obtained with the following query:

```sql
select
    country,
    operator,
    device_brand,
    count(*) as total_customers,
    round(100.0 * count(*) / sum(count(*)) over (partition by country, operator), 2) as percentage
from public_gold.gold_device_preferences
group by country, operator, device_brand
order by country, operator, total_customers desc;
```

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

These tables were obtained with the following query:

```sql
select
    plan_type,
    device_brand,
    count(*) as total_customers,
    round(100.0 * count(*) / sum(count(*)) over (partition by plan_type), 2) as percentage
from public_gold.gold_device_preferences
group by plan_type, device_brand
order by plan_type, total_customers desc;
```

## 12. Which services are most commonly contracted?

The five service types are almost equally popular, each being contracted by about 20% of the service entries. This could suggests that customers tend to subscribe to multiple services rather than favoring just one.

| Service       | Total Customers | Percentage |
|---------------|----------------:|-----------:|
| INTERNATIONAL |            2389 |      20.26 |
| VOICE         |            2364 |      20.05 |
| SMS           |            2350 |      19.93 |
| DATA          |            2348 |      19.91 |
| ROAMING       |            2341 |      19.85 |

The table was obtained with the following query:

```sql
select
    service,
    count(*) as total_customers,
    round(100.0 * count(*) / sum(count(*)) over (), 2) as percentage
from public_gold.gold_contracted_services_analysis
group by service
order by total_customers desc;
```

---

## 13. What service combinations are most popular?

Single-service contracts like `ROAMING` and `INTERNATIONAL` are quite common, but full service bundles such as `DATA,INTERNATIONAL,SMS,VOICE` are almost equally popular

| Service Combination              | Total Customers | Percentage |
|----------------------------------|----------------:|-----------:|
| ROAMING                          |             263 |       5.55 |
| INTERNATIONAL                    |             260 |       5.48 |
| SMS                              |             240 |       5.06 |
| DATA,INTERNATIONAL,ROAMING,VOICE |             239 |       5.04 |
| DATA,INTERNATIONAL,SMS,VOICE     |             236 |       4.98 |
| DATA,ROAMING,SMS,VOICE           |             236 |       4.98 |
| INTERNATIONAL,ROAMING,SMS,VOICE  |             230 |       4.85 |
| DATA                             |             220 |       4.64 |
| VOICE                            |             219 |       4.62 |
| DATA,INTERNATIONAL,ROAMING,SMS   |             215 |       4.53 |
| INTERNATIONAL,SMS,VOICE          |             134 |       2.83 |
| DATA,INTERNATIONAL,SMS           |             132 |       2.78 |
| INTERNATIONAL,ROAMING            |             130 |       2.74 |
| INTERNATIONAL,VOICE              |             128 |       2.70 |
| DATA,INTERNATIONAL,VOICE         |             128 |       2.70 |


The table was obtained with the following query:

```sql
with customer_services as (
    select
        customer_sk,
        string_agg(service, ',' order by service) as service_combination
    from public_gold.gold_contracted_services_analysis
    group by customer_sk
)

select
    service_combination,
    count(*) as total_customers,
    round(100.0 * count(*) / sum(count(*)) over (), 2) as percentage
from customer_services
group by service_combination
order by total_customers desc
limit 15;
```


## 14. What percentage of customers have payment issues?

We say a customer has payment issues if 33% or more of their payment records have status in (`'late'`, `'failed'`). At a 33% threshold, 83.09% of customers are classified as having payment issues — indicating a very high rate of problematic payment behavior. Increasing the threshold to 50% lowers this proportion to 58.23%, focusing on customers with more consistent payment problems. Further raising the threshold to 66% reduces the group to 25.97%, highlighting the most severely affected customers.

| Percentage with Payment Issues |
|-------------------------------|
|                        83.09% |

The table was obtained with the following query:

```sql
with customer_status_counts as (
    select
        customer_sk,
        count(*) as total_payments,
        sum(case when status in ('late', 'failed') then 1 else 0 end) as problematic_payments
    from public_gold.gold_payment_behavior
    group by customer_sk
),
customers_with_issues as (
    select
        customer_sk
    from customer_status_counts
    where problematic_payments * 1.0 / total_payments >= 0.33
),
total_customers as (
    select count(distinct customer_sk) as total from public_gold.gold_payment_behavior
),
issue_count as (
    select count(*) as issue_total from customers_with_issues
)
select
    round(issue_total * 100.0 / total,2) as percentage_with_payment_issues
from issue_count, total_customers;
```


---

## 15. Which customers have pending payments?

Strong correlation between low credit score and pending payments. Customers with Poor credit scores represent the majority of pending payments. Targeted intervention strategies could focus on `'Poor'` and `'Fair'` segments to reduce pending balances (e.g. reminders, flexible payment plans).

| Credit Score Group | Total Customers |
|-------------------|-----------------|
| Poor              |            1886 |
| Fair              |             653 |
| Good              |             466 |
| Very Good         |             436 |
| Excellent         |             373 |
| Unknown           |              33 |


The table was obtained with the following query:

```sql
with customers_with_pending as (
	select distinct
		customer_sk,
		credit_score_group
	from public_gold.gold_payment_behavior
	where status = 'pending'
)

select 
	credit_score_group,
	count(*) as total_customers
from customers_with_pending
group by credit_score_group
order by total_customers desc
```

---


## 16. How does credit score correlate with payment behavior?

Across all credit score groups, the four payment statuses are evenly distributed. This suggests that credit score alone is not a strong discriminator of payment behavior, at least in terms of frequency. One would expect higher credit scores to have fewer failed or late payments, but that’s not clearly reflected here.

| Credit Score Group | Payment Status | Total Payments | Percentage (%) |
|--------------------|----------------|----------------|----------------|
| Excellent          | Late           | 784            | 25.69          |
| Excellent          | Pending        | 780            | 25.56          |
| Excellent          | Paid           | 773            | 25.33          |
| Excellent          | Failed         | 715            | 23.43          |

| Credit Score Group | Payment Status | Total Payments | Percentage (%) |
|--------------------|----------------|----------------|----------------|
| Fair               | Failed         | 1381           | 26.35          |
| Fair               | Late           | 1329           | 25.36          |
| Fair               | Pending        | 1272           | 24.27          |
| Fair               | Paid           | 1258           | 24.01          |

| Credit Score Group | Payment Status | Total Payments | Percentage (%) |
|--------------------|----------------|----------------|----------------|
| Good               | Late           | 991            | 26.01          |
| Good               | Paid           | 965            | 25.33          |
| Good               | Pending        | 953            | 25.01          |
| Good               | Failed         | 901            | 23.65          |

| Credit Score Group | Payment Status | Total Payments | Percentage (%) |
|--------------------|----------------|----------------|----------------|
| Poor               | Paid           | 3931           | 25.96          |
| Poor               | Late           | 3835           | 25.33          |
| Poor               | Pending        | 3701           | 24.44          |
| Poor               | Failed         | 3675           | 24.27          |

| Credit Score Group | Payment Status | Total Payments | Percentage (%) |
|--------------------|----------------|----------------|----------------|
| Very Good          | Late           | 922            | 26.52          |
| Very Good          | Paid           | 880            | 25.31          |
| Very Good          | Pending        | 847            | 24.36          |
| Very Good          | Failed         | 828            | 23.81          |


These tables were obtained with queries like the following:

```sql
select
	credit_score_group,
    status,
    count(*) as total_payments,
    round(100.0 * count(*) / sum(count(*)) over (), 2) as percentage
from public_gold.gold_payment_behavior
group by credit_score_group, status
order by credit_score_group, total_payments desc;

```

---


## 17. How does the distribution of new customers change over time?

A graph showing customer registration over time is available in `notebooks/time_series.ipynb`. There is no clear upward or downward trend in customer registrations over time. The number of new customers fluctuates without a significant pattern, mostly oscillating between 120 and 160 registrations per month.

The graph was obtained with the following query:

```sql
select
	registration_year,
	registration_month,
	count(*) as total_customers
from public_gold.gold_customer_trends
group by registration_year, registration_month
order by registration_year, registration_month;
```

---

## 18. What are customer acquisition trends by operator?

A graph per operator showing customer registration over time is available in `notebooks/time_series.ipynb`. As before, there is no clear upward or downward trend in customer registrations over time. For each operator, the number of new customers fluctuates without a significant pattern, mostly oscillating between 20 and 45 registrations per month.

The graphs were obtained with the following query:

```sql
select
    operator,
    registration_year,
    registration_month,
    count(*) as total_customers
from public_gold.gold_customer_trends
group by operator, registration_year, registration_month
order by operator, registration_year, registration_month;
```

---

## 19. What percentage of customers are active/suspended/inactive?

The customer base is split quite evenly among suspended, inactive, and active statuses. This tells that only about one-third of customers are actively engaged, which could impact revenue and growth. This might indicate an opportunity to re-engage these segments with targeted campaigns.

| Status    | Total Customers | Percentage (%) |
|-----------|-----------------|----------------|
| Suspended | 1678            | 33.72          |
| Inactive  | 1649            | 33.13          |
| Active    | 1627            | 32.69          |
| Invalid   | 12              | 0.24           |
| Valid     | 11              | 0.22           |



The table was obtained with the following query:

```sql
select
    status,
    count(distinct customer_sk) as total_customers,
    round(100.0 * count(distinct customer_sk) / sum(count(distinct customer_sk)) over (), 2) as percentage
from public_gold.gold_customer_demographics
where status is not null
group by status
order by total_customers desc;
```

---

## 20. Which service combinations drive highest revenue?

The main revenues come from multi-service combinations.

| Service Combination                          | Average Monthly Revenue | Total Customers  |
|----------------------------------------------|-------------------------|------------------|
| DATA, ROAMING, VOICE                         | 84.58                   | 110              |
| DATA, INTERNATIONAL, SMS, VOICE              | 83.83                   | 230              |
| DATA, INTERNATIONAL, ROAMING, VOICE          | 83.40                   | 236              |
| DATA, INTERNATIONAL, ROAMING, SMS            | 82.80                   | 210              |
| INTERNATIONAL, ROAMING                       | 82.56                   | 127              |
| DATA, SMS                                    | 82.46                   | 122              |
| DATA, INTERNATIONAL, ROAMING                 | 82.42                   | 113              |
| ROAMING, VOICE                               | 82.22                   | 105              |
| SMS, VOICE                                   | 82.00                   | 112              |
| INTERNATIONAL, SMS, VOICE                    | 81.41                   | 129              |
| ROAMING, SMS                                 | 80.79                   | 112              |
| DATA, ROAMING                                | 80.72                   | 125              |
| INTERNATIONAL, VOICE                         | 80.71                   | 125              |
| INTERNATIONAL, ROAMING, SMS, VOICE           | 80.57                   | 224              |
| DATA, SMS, VOICE                             | 80.05                   | 117              |
| INTERNATIONAL, ROAMING, VOICE                | 79.75                   | 117              |
| DATA                                         | 79.37                   | 217              |
| DATA, ROAMING, SMS, VOICE                    | 79.15                   | 228              |
| DATA, INTERNATIONAL, SMS                     | 79.10                   | 129              |
| INTERNATIONAL, SMS                           | 78.84                   | 116              |
| DATA, INTERNATIONAL, VOICE                   | 78.22                   | 124              |
| INTERNATIONAL                                | 77.87                   | 252              |
| INTERNATIONAL, ROAMING, SMS                  | 77.71                   | 94               |
| VOICE                                        | 76.07                   | 211              |
| DATA, VOICE                                  | 75.58                   | 116              |
| SMS                                          | 74.07                   | 236              |
| ROAMING, SMS, VOICE                          | 73.48                   | 110              |
| DATA, ROAMING, SMS                           | 72.56                   | 120              |
| DATA, INTERNATIONAL                          | 71.87                   | 99               |
| ROAMING                                      | 70.86                   | 256              |


The table was obtained with the following query:

```sql
with service_combinations as (
    select
        cs.customer_sk,
        string_agg(distinct cs.service, ', ' order by cs.service) as service_combo
    from public_gold.gold_contracted_services_analysis cs
    group by cs.customer_sk
)

select
    sc.service_combo,
    round(avg(mc.monthly_bill_usd), 2) as avg_monthly_revenue,
    count(distinct sc.customer_sk) as total_customers
from service_combinations sc
join public_gold.gold_contracted_services_analysis cs
    on sc.customer_sk = cs.customer_sk
join public_gold.gold_customer_revenue_metrics mc
    on cs.customer_sk = mc.customer_sk
group by sc.service_combo
order by avg_monthly_revenue desc;

```

---

## 21. How do the mean and median monthly revenues per user compare across different plan types and operators?

| Plan Type | Operator | Mean Monthly Revenue  | Median Monthly Revenue  | Total Customers  |
|-----------|----------|-----------------------|-------------------------|------------------|
| Control   | Claro    | 79.00                 | 77.01                   | 422              |
| Control   | Movistar | 79.20                 | 79.27                   | 397              |
| Control   | Tigo     | 79.31                 | 78.27                   | 429              |
| Control   | WOM      | 74.92                 | 72.98                   | 397              |

| Plan Type | Operator | Mean Monthly Revenue  | Median Monthly Revenue  | Total Customers  |
|-----------|----------|-----------------------|-------------------------|------------------|
| Pospago   | Claro    | 77.16                 | 76.17                   | 412              |
| Pospago   | Movistar | 80.94                 | 82.49                   | 377              |
| Pospago   | Tigo     | 78.99                 | 80.69                   | 408              |
| Pospago   | WOM      | 77.20                 | 77.91                   | 418              |

| Plan Type | Operator | Mean Monthly Revenue  | Median Monthly Revenue  | Total Customers  |
|-----------|----------|-----------------------|-------------------------|------------------|
| Prepago   | Claro    | 78.92                 | 76.79                   | 410              |
| Prepago   | Movistar | 78.09                 | 74.72                   | 384              |
| Prepago   | Tigo     | 79.50                 | 80.05                   | 396              |
| Prepago   | WOM      | 81.33                 | 78.09                   | 421              |


The table was obtained with the following query:

```sql
select
    plan_type,
    operator,
    round(avg(monthly_bill_usd)::numeric, 2) as mean_monthly_revenue,
    round(
    	percentile_cont(0.5) within group (order by monthly_bill_usd)::numeric, 2
    ) as median_monthly_revenue,
    count(distinct customer_sk) as total_customers
from public_gold.gold_customer_revenue_metrics
group by plan_type, operator
order by plan_type, operator;

```
