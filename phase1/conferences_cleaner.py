# Cleaner for KDD Cup 2016 Conferences.txt
# You can get Conferences.txt from
# https://s3.amazonaws.com/kddcup2016-ghen/Conferences.txt

import csv

CONFERENCE_FILE='./Conferences.txt'
CLEANED_CONFERENCE_FILE='./Conferences_Cleaned.tsv'

outfile = open(CLEANED_CONFERENCE_FILE, 'w')

with open(CONFERENCE_FILE, 'rb') as infile:
   tsvdata = csv.reader(infile, delimiter='\t')
   for row in tsvdata:
       # Validate row and write valid rows to a new file, do something better later
       if row[1] == 'SIGIR' or row[1] == 'SIGMOD' or row[1] == 'SIGCOMM':
           outfile.write(row[0]+'\t'+row[1]+'\t'+row[2]+'\n')
