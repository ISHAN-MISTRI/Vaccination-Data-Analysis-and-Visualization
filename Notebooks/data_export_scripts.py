# Export cleaned DataFrames to CSVs for PostgreSQL import
# from google.colab import files

for name, df in cleaned_tables.items():
    try:
        # Save each DataFrame with a simple name (consistent with SQL tables)
        df.to_csv(f"{name}.csv", index=False)
        print(f"Exported {name} to {name}.csv")
    except Exception as e:
        print(f"Error exporting {name}: {e}")


# Download all exported CSVs

files.download("coverage_data.csv")
files.download("incidence_rate.csv")
files.download("reported_cases.csv")
files.download("vaccine_introduction.csv")
files.download("vaccine_schedule.csv")
