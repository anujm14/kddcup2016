# Team Titans!

## KDD Cup 2016: Towards measuring the impact of research institutions

This repository contains some publicly available resources for analyzing and interacting with Microsofts Academic Graph data.

# KDDB: Ruby on Rails Application for Select KDD data

:warning: Live Demo: http://kdddb.fu2igtbxwf.us-east-1.elasticbeanstalk.com/welcome/index :warning:

Using Ruby on Rails and Postgres, this application running on AWS Elastic Beanstalk allows you to view the Author and Affiliation scores our team computed for each Paper, Author, Affiliation combination of interest.

Supports seeding from publicly available select KDD data stored on AWS S3 files.

```
bundle exec rake db:reset
```

Loads the scores for the data for you! :boom:

```
Building Papers from https://s3.amazonaws.com/kddcup2016-ghen/Papers.tsv: |===================================================|
Building Affiliations from https://s3.amazonaws.com/kddcup2016-ghen/Affiliations.tsv: |=======================================|
Building PapersAuthorsAffiliations from https://s3.amazonaws.com/kddcup2016-ghen/PapersAuthorsAffiliations.tsv: |=============|
Scoring https://s3.amazonaws.com/kddcup2016-ghen/PapersAuthorsAffiliations.tsv: |=============================================|
```
:note: Ignores Author names becuase who want to deal with 1GB of non-ascii characters...
Access the database to query with SQL:

```
bundle exec rails db
```

Use the Rails API to build views or use Ruby:

```
bundle exec rails server
```

Then go to: http://localhost:3000/welcome/index.


# Phase 1

That directory holds some scripts used to clean the data for Phase 1
