# Cleaner for KDD Cup 2016 Author.text
import csv

AUTHOR_FILE=''
CLEANED_AUTHOR_FILE=''

outfile = open(CLEANED_AUTHOR_FILE, 'w')

with open(AUTHOR_FILE, 'rb') as infile:
    tsvdata = csv.reader(infile, delimiter='\t')
    for row in tsvdata:
        # Validate row and write valid rows to a new file
        
