# Vaccination Data Analysis & Visualization

## 📌 Project Overview
This project analyzes **global vaccination datasets** to uncover insights into coverage, disease incidence, and vaccine effectiveness.  
The workflow integrates **Python (Colab)** for cleaning & EDA, **PostgreSQL** for structured storage and queries, and **Power BI** for interactive dashboards.

Deliverables:
- Cleaned datasets (CSV files)
- SQL schema and queries
- Google Colab notebook with EDA & exports
- Power BI dashboards (Easy, Medium, Scenario)
- Final report (PDF) and presentation

---

## 🗂️ Repository Structure
vaccination-project/
├─ data/ # Cleaned CSVs exported from Colab
├─ notebooks/ # Colab notebook + helper scripts
├─ sql/ # PostgreSQL schema + queries
├─ powerbi/ # Power BI .pbix file
├─ docs/ # Report PDF + screenshots
└─ README.md # This file


---

## ⚙️ How to Run
1. Open `notebooks/Vaccination_Data_Analysis_and_Visualization.ipynb` in Colab.  
   - Run cleaning & EDA.  
   - Export CSVs to `data/`.  
2. In PostgreSQL (pgAdmin or psql):  
   - Run `sql/create_schema_and_tables.sql`.  
   - Import CSVs into tables.  
   - Run `sql/queries_for_report.sql` for analysis.  
3. Open `powerbi/Vaccination_Dashboards.pbix` in Power BI Desktop.  
   - Dashboards: Easy, Medium, Scenario.  
   - Slicers: Year, Country, WHO Region.  

---

## 🎯 Business Use Cases
- Identify **low-coverage regions** for targeted interventions.  
- Track **impact of vaccine introductions** on disease incidence.  
- Evaluate **booster uptake** and drop-offs between doses.  
- Support **policy planning** with scenario dashboards.  

---

## 📊 Dashboards
- **Easy Dashboard:** 10 fundamental questions (coverage vs incidence, dose drop-off, booster uptake, seasonal trends).  
- **Medium Dashboard:** 10 analytical questions (before/after vaccine introduction, coverage vs cases by antigen, disparities by region).  
- **Scenario Dashboard:** 10 real-world scenarios (resource allocation, outbreak response, demand forecasting, WHO targets).  

---

## 📑 Report & Presentation
- `docs/final_report.pdf`: Written summary of data cleaning, SQL setup, Power BI dashboards, and insights.  
- `docs/screenshots/`: Dashboard screenshots for presentation.  

---

## 🔧 Tech Stack
- Python (Pandas, Matplotlib, Seaborn, SQLAlchemy)  
- PostgreSQL (DDL, queries, pgAdmin)  
- Power BI (interactive dashboards)  

---
