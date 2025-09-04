# P12_Ecommerce-Customer-Analysis

**VERSION 1**

**A. Project Overview**

- This project Ecommerce's Performance of Company X by Basic KPI & Segment customer by RFM Methods

![Dashboard Visualization](https://github.com/CallmeNavin/P12_Ecommerce-Customer-Analysis/blob/main/Version%201/Visualization/Overview.png)
_Explore more insights in the full Power BI dashboard_

**B. Dataset Information**

**Source**

- Name: kisaraf01.ecommerce_customer_data_large
- From Mode - Sample Dataset

**Period**

- Jan 2020 to Sep 2023

**C. Methodology**

- Basic EDA - Check Completeness:
  + Columns Types
  + Time range
  + %Blank/null
  + %Zero Value
  + Outliers
- Basic KPI:
  + Revenue
  + Numbers of Orders
  + AOV
- Group by:
  + Product Category
  + Payment Methods
  + Both
- Trend by time: Dùng Date_trunc để chuyển hóa cột purchase_date về tháng
- Top/Bottom Ranking:
  + Top 10 Customers spend most
  + Top 1 Best-seller Product Category
- Advanced Analysis: RFM (Recency - Frequency - Monetary) Segmentation

**D. Key Findings & Actionable Plans**

**_Key Findings_**

- Home Category generates the highest revenue and AOV → customers are willing to spend more → sustainable profit driver.
- Electronics Category records the highest total orders (best-sellers) but lowest revenue & AOV → popular in volume but not optimized for profitability → mainly acts as a traffic driver.
- Customers tend to pay through credit cards, especially for Clothing & Electronics → indicating easier spending when credit options are available.
- Revenue & Orders peak in mid-year (July–August) but decline sharply in Q4.
- Customer Segmentation reveals a risky balance: Champions nearly equal Lost Customers, while Loyal & Potential segments remain underdeveloped (<6%) → although high-value customers exist, churn risk is also significant.

**_Actionable Plans_**

- Category Strategy: Leverage Electronics as entry products, then design targeted cross-sell campaigns to Home items (e.g., desk, furniture, lighting for electronic buyers).
- Payment Method Strategy: Strengthen partnerships with banks (cashback, credit card promotions), especially for Clothing & Electronics.
- Seasonality Strategy: Maintain strong mid-year sales campaigns, but introduce additional Q4 incentives (Holiday Season, Black Friday, Christmas) to stabilize year-end performance.
- Customer Loyalty Strategy:
  + Develop exclusive care programs for Champions (membership, premium offers).
  + Convert Potential → Loyal by:
    - Lowering loyalty thresholds by customer tier (e.g., fewer orders required to upgrade status).
    - Offering personalized recommendations based on last purchase.
    - Launching double-incentive campaigns to increase both frequency & monetary value (e.g., “Order within 14 days → +200 points. Orders above $60 → extra 10% voucher”).

**E. Appendix**

_**RFM Analysis Model**_

| Segment                 | Recency (R)                     | Frequency (F)        | Monetary (M)             | Business Meaning                                  |
| ----------------------- | ------------------------------- | -------------------- | ------------------------ | ------------------------------------------------- |
| **Champions**           | High (4–5)  | High (4–5) | High (4–5) | VIP customers, loyal and highly valuable          |
| **Loyal Customers**     | Medium (3–4)                    | High (4–5)           | Medium (3–4)             | Regular shoppers, consistent but not top spenders |
| **Potential Loyalists** | High (4–5)                      | Low (1–2)            | Medium (2–3)             | Recently active, lower frequency, good potential  |
| **At Risk**             | Low (1–2) | High (4–5)           | High (4–5)               | Once valuable, now disengaged, need reactivation  |
| **Lost**                | Low (1–2)                       | Low (1–2)            | Low (1–2)                | Almost lost, minimal value                        |
| **Others**              | Mixed combinations              |                      |                          | Customers who don’t clearly fit into main groups  |


_**About Me**_

Hi, I'm Navin (Bao Vy) – an aspiring Data Analyst passionate about turning raw data into actionable business insights.
I’m eager to contribute to data-driven decision making and help organizations translate analytics into business impact.
For more details, please reach out at:

🌐 LinkedIn: https://www.linkedin.com/in/navin826/

📂 Portfolio: https://github.com/CallmeNavin/
