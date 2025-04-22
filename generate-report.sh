#!/bin/bash

# Define file paths
CSV_FILE="sales-data.csv"
REPORT_FILE="report.html"

# Initialize totals
TOTAL_UNITS=0
TOTAL_REVENUE=0

# Process the CSV file (skip header)
while IFS=',' read -r date product units sold revenue
do
  if [[ "$date" != "Date" ]]; then  # Skip header line
    # Add units sold and revenue to totals
    TOTAL_UNITS=$((TOTAL_UNITS + units))
    TOTAL_REVENUE=$(echo "$TOTAL_REVENUE + $revenue" | bc)
  fi
done < "$CSV_FILE"

# Generate the HTML report
cat <<EOF > "$REPORT_FILE"
<html>
<head><title>Sales Report</title></head>
<body>
<h1>Sales Summary</h1>
<p>Total Units Sold: $TOTAL_UNITS</p>
<p>Total Revenue: $$TOTAL_REVENUE</p>
</body>
</html>
EOF

echo "Report generated: $REPORT_FILE"
