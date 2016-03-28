# Cleaner for KDD Cup 2016 Author.text
####Listing of Column Headers:
#Conference ID
#Conference instance ID
#Short name (abbreviation)
#Full name
#Location
#Official conference URL
#Conference start date
#Conference end date
#Conference abstract registration date
#Conference submission deadline date
#Conference notification due date
#Conference final version due date

import csv

CONFERENCE_INSTANCE_FILE='./ConferenceInstances.txt'
CLEANED_CONFERENCE_INSTANCE_FILE='./CleanConferenceInstances.tsv'

 
outfile = open(CLEANED_CONFERENCE_INSTANCE_FILE, 'wb')
tsv_outfile = csv.writer(outfile, delimiter='\t')

with open(CONFERENCE_INSTANCE_FILE, 'rb') as infile:
    tsvdata = csv.reader(infile, delimiter='\t')
    for row in tsvdata:
        # Validate row and write valid rows to a new file
        # we want row[2] Short name 
        if row[0] == '460A7036' or row[0] == '43FD776C' or row[0] == '44B13001':
            #print("DING!!!")
            tsv_outfile.writerow(row)
                                

