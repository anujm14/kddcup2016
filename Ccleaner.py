# Cleaner for KDD Cup 2016 Author.text
import csv

CONFERENCE_FILE='./Conferences.txt'
CLEANED_CONFERENCE_FILE='./CleanConf.tsv'

outfile = open(CLEANED_CONFERENCE_FILE, 'w')

with open(CONFERENCE_FILE, 'rb') as infile:
    tsvdata = csv.reader(infile, delimiter='\t')
    for row in tsvdata:
        # Validate row and write valid rows to a new file
        if row[1] == 'SIGIR' or row[1] == 'SIGMOD' or row[1] == 'SIGCOMM':
            outfile.write(row[0]+'\t'+row[1]+'\t'+row[2]+'\n')
                                

