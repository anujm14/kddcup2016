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
    return str(random.uniform(0,1))[0:9]

AFFILIATIONS_FILE='./KDDAffiliations.txt'
CONFERENCES_FILE='./KDDConferences.txt'
RANKINGS_FILE='./Rankings.txt'
RESULTS_FILE='./results.tsv'
SIGMOD_ID='460A7036'
SIGIR_ID='43FD776C'
SIGCOMM_ID='44B13001'

affiliations = pandas.read_csv(AFFILIATIONS_FILE, sep='\t', names=['affiliation_id', 'affiliation_name'])
conferences = pandas.read_csv(CONFERENCES_FILE, sep='\t', names=['conference_id', 'short_name', 'conference_name'])

sigmod = pandas.DataFrame(columns=('conference_id','affiliation_id','probability_score'))

sigmod['affiliation_id'] = affiliations['affiliation_id']
sigmod['conference_id'] = sigmod['conference_id'].fillna(SIGMOD_ID)
sigmod['probability_score'] = sigmod['affiliation_id'].apply(lambda x: probability_score(x,SIGMOD_ID))

sigir = pandas.DataFrame(columns=('conference_id','affiliation_id','probability_score'))

sigir['affiliation_id'] = affiliations['affiliation_id']
sigir['conference_id'] = sigir['conference_id'].fillna(SIGIR_ID)
sigir['probability_score'] = sigir['affiliation_id'].apply(lambda x: probability_score(x,SIGIR_ID))

sigcomm = pandas.DataFrame(columns=('conference_id','affiliation_id','probability_score'))

sigcomm['affiliation_id'] = affiliations['affiliation_id']
sigcomm['conference_id'] = sigcomm['conference_id'].fillna(SIGCOMM_ID)
sigcomm['probability_score'] = sigcomm['affiliation_id'].apply(lambda x: probability_score(x,SIGCOMM_ID))

frames = [sigmod, sigir, sigcomm]
result = pandas.concat(frames)
result.to_csv(RESULTS_FILE, sep='\t', header=False, index=False)
