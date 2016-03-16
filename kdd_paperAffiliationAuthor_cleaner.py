# Get the relevant KDD Papers

import csv
import urllib2

# SEE url below for data and schemas:
"""
https://academicgraph.blob.core.windows.net/graph-2016-02-05/index.html
"""

PAA_FILE='./PaperAuthorAffiliations.txt'
PAA_FILE_URL='./Papers.txt'  ### Update me 

# PAA FORMAT:
"""
Paper ID
Author ID
Affiliation ID
Original affiliation name
Normalized affiliation name
Author sequence number
"""

KDD_PAPERS_FILE='./2016KDDCupSelectedPapers.txt'
KDD_PAPERS_FILE_URL='https://s3.amazonaws.com/kddcup2016-ghen/2016KDDCupSelectedPapers.txt'

#KDD FORMAT
"""
Paper ID
Original paper title
Paper publish year
Conference ID mapped to venue name
Conference short name (abbreviation)
"""

CLEANED_PAA_FILE='cleanPaperAuthorAffiliations.tsv'

paperIdArray=[]
useInternet = False

### This isn't even close to working or being tested
if useInternet:
    data = urllib2.urlopen(KDD_PAPERS_FILE_URL) 
    tsvdata = csv.reader(infile, delimiter='\t')
       

### Requires that you have a 25GB file hanging out in local storage...
if not useInternet:
    #Get the IDs of all the KDD papers we care about
    with open(KDD_PAPERS_FILE, 'rb') as infile:
        tsvdata = csv.reader(infile, delimiter='\t')
        for row in tsvdata:
            paperIdArray.append(row[0])

    outfile = open(CLEANED_PAA_FILE, 'wb')
    tsv_outfile = csv.writer(outfile, delimiter='\t')

    #Use the KDD IDs to select relevant papers from the Master Papers list
    with open(PAA_FILE, 'rb') as infile:
        #We need QUOTE_NONE in case there's some junk quotes in the data
        tsvdata = csv.reader(infile, delimiter='\t', quoting=csv.QUOTE_NONE)
        for row in tsvdata:
            if row[0] in paperIdArray:
                #print("got one: "+ row[0])
                tsv_outfile.writerow(row)
