# Primative Ranking algorithm that randomly generates a number between 0 and 1
# using a hash of the affiliation. This is designed to be a random guess at the
# rank of the affiliations for the conferences.

import random
import csv
import pandas

def probability_score(conference_id, affiliation_id):
    """
    This is a base line random guess at rankings. It ensures each conference_id
    and affiliation_id pair gets the same probability_score by seeding random
    """
    random.seed(conference_id + affiliation_id)
    return random.uniform(0,1)

AFFILIATIONS_FILE='./KDDAffiliations.txt'
CONFERENCES_FILE='./KDDConferences.txt'
RANKINGS_FILE='./Rankings.txt'

affiliations = pandas.DataFrame.from_csv(AFFILIATIONS_FILE, sep='\t')
conferences = pandas.DataFrame.from_csv(CONFERENCES_FILE, sep='\t')

print(affiliations)
print(conferences)
