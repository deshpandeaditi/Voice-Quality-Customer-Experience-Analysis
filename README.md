# 📞 Voice Call Quality Customer Experience Analysis

This project analyzes user-reported voice call quality data collected through the TRAI MyCall app in India during 2023. The analysis evaluates mobile operators, network types, and call drop trends across Indian states using SQL, Power BI, and statistical testing.

---

## 📌 Project Overview

- 📅 **Year:** 2023  
- 📍 **Region:** India  
- 📡 **Source:** TRAI MyCall App (via National Data Sharing and Accessibility Policy)  


Users rated their voice call experience in real-time, contributing insights into call quality, call drops, network type (2G/3G/4G), and indoor vs. outdoor usage. The goal is to identify performance trends and visualize actionable insights.

---

## 📁 Dataset Description

Each record in the dataset represents a customer-submitted feedback point and includes:

| Column             | Description                                        |
|--------------------|----------------------------------------------------|
| `Operator`         | Mobile operator used (e.g., Airtel, Jio, Vi)       |
| `Inout_travelling` | Indicates Indoor or Outdoor call                   |
| `Network_type`     | Network type used (2G, 3G, 4G)                      |
| `Rating`           | User experience rating (scale of 1–5)              |
| `Calldrop_category`| Classification of call drop or experience type     |
| `Latitude`         | User's latitude (invalid = -1 were removed)        |
| `Longitude`        | User's longitude (invalid = -1 were removed)       |
| `State_name`       | Indian state where call took place                 |

---

## 🎯 Business Questions Answered

1. 📶 Which operator is best rated overall and by state?
2. 🌐 Is there a correlation between network type (2G/3G/4G) and user rating?
3. 📉 Are call drops correlated with lower ratings?
4. 🏠 Indoor vs. Outdoor: Which environment has more call drops?  


---

## 🔍 Key Insights 

- **Best Operators by State:**
  - Vi performed best in Andhra Pradesh.
  - Jio dominated Bihar and Chhattisgarh.
  - Airtel led in Delhi and indoor usage in Chhattisgarh.

- **Network Type:**
  - 4G showed the highest average ratings.
  - 2G and 3G lagged significantly.

- **Call Drop Impact:**
  - 'Call Dropped' category had an average rating of **1.21**
  - 'Satisfactory' calls had a rating of **4.20**

- **Indoor vs. Outdoor (Hypothesis Test):**
  - Indoor drop rate: **3.52%**
  - Outdoor drop rate: **6.54%**
  - Outdoor calls are statistically more prone to drops.

---

## 📊 Power BI Dashboard Features

The interactive Power BI file (`VoiceQualityCustomerExperience.pbix`) includes:
- Best operator by state heatmap
- Network-type-wise rating analysis
- Call drop distribution and filters
- Indoor vs. outdoor comparisons
- Slicers for filtering by operator, state, and network type

---

## 🛠️ Tools Used

- **SQL** – Data extraction and cleaning (`VoiceQuality_SqlQueries.sql`)
- **Power BI** – Interactive visual dashboard
- **Excel** – Data inspection and validation
- **Python (optional)** – For statistical hypothesis testing



