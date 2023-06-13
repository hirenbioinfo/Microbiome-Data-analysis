#!/bin/bash
#SBATCH --job-name=fastp
#SBATCH -c 8
#SBATCH -p long
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --mail-type=END
#SBATCH --mail-user=hiren.ghosh@gmail.com
# here starts your actual program call/computation

# Read the data directory path from the command line argument
data_dir="$1"

# Verify that a data directory path is provided
if [ -z "$data_dir" ]; then
    echo "Please provide the data directory path as a command-line argument."
    exit 1
fi

# Iterate over the tarball files in the data directory
for file in "${data_dir}"/*.tar.gz; do
    # Get the base filename without the extension
    filename=$(basename "$file" .tar.gz)

    # Extract the sample name (e.g., sub1) from the filename
    sample_name="${filename%_*}"

    # Specify the input files (extracted FASTQ files)
    input_r1="${data_dir}/${sample_name}_1.fq.tar.gz"
    input_r2="${data_dir}/${sample_name}_2.fq.tar.gz"

    # Specify the output filenames based on the sample name
    output_r1="${data_dir}/${sample_name}_R1.fastq.gz"
    output_r2="${data_dir}/${sample_name}_R2.fastq.gz"

    # Specify the output filenames for HTML and JSON based on the sample name
    output_html="${data_dir}/${sample_name}.html"
    output_json="${data_dir}/${sample_name}.json"

    # Run Fastp with HTML and JSON output options
    fastp -i "$input_r1" -o "$output_r1" -I "$input_r2" -O "$output_r2" --html "$output_html" --json "$output_json" [options...]

    # Print the processed file names
    echo "Processed: ${input_r1}, ${input_r2}"
    echo "Output files: ${output_r1}, ${output_r2}"
    echo "HTML output: ${output_html}"
    echo "JSON output: ${output_json}"
done