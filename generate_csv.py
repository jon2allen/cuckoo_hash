import requests
import csv
import random
from datetime import datetime, timedelta

def generate_test_data():
    # 1. Gather 200 model names from Hugging Face
    print("Fetching model names from Hugging Face...")
    url = "https://huggingface.co/api/models?limit=200"
    response = requests.get(url)
    response.raise_for_status()
    models = response.json()
    
    model_names = [m['modelId'] for m in models]
    
    # If we got fewer than 200 (unlikely for HF), we should handle it, 
    # but the API definitely has thousands.
    if len(model_names) < 200:
        print(f"Warning: Only found {len(model_names)} models.")

    # 2. Setup date range: Jan 1st, 2026 to Today (Feb 19th, 2026)
    start_date = datetime(2026, 1, 1)
    end_date = datetime(2026, 2, 19)
    time_between_dates = end_date - start_date
    days_between_dates = time_between_dates.days

    # 3. Generate CSV
    filename = "models_test_data.csv"
    print(f"Generating {filename}...")
    
    with open(filename, mode='w', newline='', encoding='utf-8') as f:
        writer = csv.writer(f)
        # Assuming we need a header based on the description, 
        # but the prompt says "1st column is...", "2nd is..." 
        # usually suggests no header or specific header.
        # I'll include a header for clarity.
        writer.writerow(["model_name", "num_used", "last_date_used"])
        
        for name in model_names:
            num_used = random.randint(1, 100)
            
            # Random date
            random_days = random.randrange(days_between_dates + 1)
            random_date = start_date + timedelta(days=random_days)
            date_str = random_date.strftime("%Y-%m-%d")
            
            writer.writerow([name, num_used, date_str])
            
    print(f"Success! Created {filename} with {len(model_names)} entries.")

if __name__ == "__main__":
    generate_test_data()
