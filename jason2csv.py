# combined the jason output from fastp

import json
import csv
import os

# Directory containing JSON files
data_dir = "/Users/hirenghosh/Downloads/attachments_all"

# Output CSV file
output_csv = "/Users/hirenghosh/Downloads/attachments_all/output.csv"

# List to store combined data
combined_data = []
# Iterate over the JSON files in the directory
for file_name in os.listdir(data_dir):
    if file_name.endswith(".json"):
        file_path = os.path.join(data_dir, file_name)
        with open(file_path) as json_file:
            data = json.load(json_file)
            data['file_name'] = file_name  # Add file name to data
            combined_data.append(data)

# Extract specific fields from each JSON file
extracted_data = []
for data in combined_data:
    before_filtering = data['summary']['before_filtering']
    after_filtering = data['summary']['after_filtering']
    filtering_result = data['filtering_result']

    extracted_data.append({
        "File Name": data['file_name'],  # Add file name to extracted data
        "Total Reads (Before Filtering)": before_filtering['total_reads'],
        "Total Bases (Before Filtering)": before_filtering['total_bases'],
        "Q20 Bases (Before Filtering)": before_filtering['q20_bases'],
        "Q30 Bases (Before Filtering)": before_filtering['q30_bases'],
        "Total Reads (After Filtering)": after_filtering['total_reads'],
        "Total Bases (After Filtering)": after_filtering['total_bases'],
        "Q20 Bases (After Filtering)": after_filtering['q20_bases'],
        "Q30 Bases (After Filtering)": after_filtering['q30_bases'],
        "Passed Filter Reads": filtering_result['passed_filter_reads'],
        "Low Quality Reads": filtering_result['low_quality_reads'],
        "Too Many N Reads": filtering_result['too_many_N_reads'],
        "Too Short Reads": filtering_result['too_short_reads'],
        "Too Long Reads": filtering_result['too_long_reads'],
        "Read1 Mean Length": before_filtering['read1_mean_length'],
        "Read2 Mean Length": before_filtering['read2_mean_length'],
        "GC Content": before_filtering['gc_content']
    })

# Determine the fieldnames for the CSV
fieldnames = extracted_data[0].keys()

# Write extracted data to CSV file
with open(output_csv, mode="w") as csv_file:
    writer = csv.DictWriter(csv_file, fieldnames=fieldnames)
    writer.writeheader()
    writer.writerows(extracted_data)

print("CSV output created:", output_csv)