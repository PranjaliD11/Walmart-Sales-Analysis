# **Walmart Sales Data Analysis: End-to-End Business Insights**  

## **Project Overview**  

This project is an end-to-end data analysis solution designed to extract critical business insights from Walmart sales data. We utilize **Python** for data processing and analysis, **SQL** for advanced querying, and structured problem-solving techniques to address key business questions.  

### **Objectives:**  
- Identify sales trends and revenue patterns across different locations and product categories.  
- Optimize inventory management by understanding demand fluctuations.  
- Analyze customer purchase behavior based on time, city, and payment method.  
- Improve profitability by identifying high-margin products and peak sales periods.  

---

## **Project Workflow**  

### **1. Environment Setup**  
- **Tools Used**: Visual Studio Code (VS Code), Python, MySQL, PostgreSQL  
- **Goal**: Create a structured workspace within VS Code and organize project folders for smooth development and data handling.  

### **2. Kaggle API Setup & Data Download**  
- **API Configuration**:  
  - Obtain the Kaggle API token from [Kaggle](https://www.kaggle.com/).  
  - Place the downloaded `kaggle.json` file in the local `.kaggle` folder.  
  - Use the command:  
    ```bash
    kaggle datasets download -d <dataset-path>
    ```  
- **Dataset Link**: [Walmart Sales Dataset](https://www.kaggle.com/najir0123/walmart-10k-sales-datasets)  

### **3. Install Required Libraries & Load Data**  
- **Install Dependencies:**  
  ```bash
  pip install pandas numpy sqlalchemy mysql-connector-python psycopg2
  ```  
- **Read Data in Python:**  
  ```python
  import pandas as pd
  df = pd.read_csv("walmart_sales.csv")
  ```  

### **4. Exploratory Data Analysis (EDA)**  
- **Initial Exploration:**  
  - View dataset structure: `.info()`, `.describe()`, `.head()`  
  - Identify missing values and inconsistencies.  
- **Key Observations:**  
  - Product categories and their revenue distribution.  
  - Variation in sales across branches and time periods.  

### **5. Data Cleaning & Transformation**  
- **Handling Missing Data:** Remove or impute missing values.  
- **Fixing Data Types:** Convert dates to `datetime`, currency to `float`, etc.  
- **Removing Duplicates:** Ensure data integrity.  
- **Feature Engineering:**  
  - Create `Total Amount = unit_price * quantity` column for transaction-level insights.  
  - Categorize sales periods (e.g., weekdays vs. weekends).  

### **6. Data Storage in MySQL & PostgreSQL**  
- **Set Up Database Connection:** Use `SQLAlchemy` for efficient data handling.  
- **Table Creation & Data Insertion:**  
  ```python
  from sqlalchemy import create_engine
  engine = create_engine('mysql+mysqlconnector://user:password@host/db_name')
  df.to_sql('walmart_sales', con=engine, if_exists='replace', index=False)
  ```  
- **Validation:** Execute SQL queries to verify correct data loading.  

### **7. SQL Analysis: Business Insights**  
We used complex SQL queries to address key business questions:  

- **Branch Performance:**  
  ```sql
  SELECT branch, SUM(profit) AS total_profit
  FROM walmart_sales
  GROUP BY branch
  ORDER BY total_profit DESC;
  ```  
  📌 *Result:* WALM052 in Mansfield had the highest profit.  

- **Best-Selling Categories:**  
  ```sql
  SELECT category, SUM(total_amount) AS revenue
  FROM walmart_sales
  GROUP BY category
  ORDER BY revenue DESC;
  ```  
  📌 *Result:* Fashion Accessories and Home Lifestyle had the highest revenue and profit margins.  

- **Sales Trends Over Time:**  
  ```sql
  SELECT DATE_FORMAT(date, '%Y-%m') AS month, SUM(total_price) AS revenue
  FROM walmart_sales
  GROUP BY month
  ORDER BY month;
  ```  
  📌 *Insight:* Peak sales were observed during holiday seasons.  

- **Customer Buying Patterns:**  
  - Most transactions occurred during weekends.  
  - Credit card payments dominated high-value purchases.  

---

## **Key Business Insights**  

✅ **Branch Performance:** *WALM052 in Mansfield generated the highest profit.*  
✅ **Profitability Analysis:** *Fashion Accessories and Home Lifestyle had the highest profit margins.*  
✅ **Sales Trends:** *Peak sales occurred during holiday seasons, highlighting the need for seasonal inventory planning.*  
✅ **Customer Behavior:** *Weekend sales were higher, and credit card purchases were dominant for high-value items.*  

---

## **Future Enhancements**  

🚀 **Dashboard Integration:**  
- Develop **Tableau or Power BI** dashboards for real-time data visualization.  
- Create interactive reports for executive decision-making.  

🛠 **Automating the Data Pipeline:**  
- Implement **scheduled data ingestion** for continuous monitoring.  
- Use **ETL workflows** to process large datasets efficiently.  

📊 **Advanced Analytics & Machine Learning:**  
- Build a **sales forecasting model** using time series analysis.  
- Perform **customer segmentation** based on purchasing behavior.  

---

## **Acknowledgments**  
- **Data Source:** Kaggle’s Walmart Sales Dataset  
- **Inspiration:** Walmart’s case studies on sales and supply chain optimization  

---
