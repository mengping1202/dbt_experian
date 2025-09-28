import json
import csv
import uuid
import glob
import os
from datetime import datetime

# Get the directory where this script lives
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# Find all folders named "responses" under BASE_DIR/*
response_folders = glob.glob(os.path.join(BASE_DIR, "*", "responses"))

if not response_folders:
    print(f"No 'responses' folders found under {BASE_DIR}")
else:
    for input_folder in response_folders:
        parent_folder = os.path.dirname(input_folder)  # e.g., RegisteredCompanyCredit
        output_csv = os.path.join(parent_folder, "api_logs.csv")

        print(f"Processing {input_folder} -> {output_csv}")

        # Define CSV columns
        columns = ["response_id", "created_at", "request_id", "api_response"]
        rows = []

        # Collect all JSON files in this responses folder
        files = glob.glob(os.path.join(input_folder, "*.json"))

        for f in files:
            with open(f, "r", encoding="utf-8") as infile:
                data = json.load(infile)

                response_id = str(uuid.uuid4())
                created_at = datetime.utcnow().isoformat()
                request_id = str(uuid.uuid4())
                api_response = json.dumps(data)

                rows.append([response_id, created_at, request_id, api_response])

        if rows:
            with open(output_csv, "w", newline="", encoding="utf-8") as outfile:
                writer = csv.writer(outfile)
                writer.writerow(columns)
                writer.writerows(rows)

            print(f"Wrote {len(rows)} rows to {output_csv}")
        else:
            print(f"No JSON files found in {input_folder}")
