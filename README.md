# google_scrape

This application allows you to scrape and extract the ads of a keyword
search on a search engine. As the name doesn't imply, the search engine
currently is Yahoo! because it answers with more ads than Google.

# What works, what doesn't

In the span of time that was allotted, the following features could be
implemented:

* Create a new report with manually entered keywords 
* List reports, open old ones
* For each report's keywords, see some summary information and the
  cached page
* Provide a JSON API

  If you're seeing the report with id 2:
  ```
  GET /reports/2
  ```

  and want to see the same report with all keywords and urls as JSON,
  append ".json" to the url:
  ```
  GET /reports/2.json
  ```

* A demo instance is hosted on heroku, at the following address:
  https://googlescrapen3.herokuapp.com/


There are, however, multiple shortcomings:

* No UI refinements. The default rail theme is used
* No User and session management. Everybody share all the reports, and
  there is no access control
* No CSV ingester. The current way of working (1 keyword per line) is a
  workaround.
* No possibility to query the data
* Adding keywords for a report is a synchronous operation that could
  possibly take a long time. The obvious next step here is to make it
  asynchronous.
* No tests

# How to install locally

* Install Postgresql
  * Create user google_scrape

    ```
    postgres$ createuser --interactive
    ```

  * Create db google_scrape

    ```
    postgres$ createdb google_scrape
    ```

  * Create db google_scrape_dev

    ```
    postgres$ createdb google_scrape
    ```

* Clone and install this repository

```
$ git clone <...>
$ bundle install
$ DATABASE_URL=postgres://postgres@localhost:5432/google_scrape_dev rake db:setup
```

* Grant db privileges to the running user:

```
postgres$ psql google_scrape_dev
google_scrape_dev=# GRANT ALL PRIVILEGES ON reports,schema_migrations,keywords,urls TO google_scrape; 
google_scrape_dev=# GRANT ALL ON SEQUENCE reports_id_seq,keywords_id_seq,urls_id_seq TO google_scrape;
```

# How to install on heroku

Same procedure, except users are automatically created. You only need to
run the grant privileges commands, replacing the user with the one that
was automatically created for you.

# How to run

```
$ DATABASE_URL=postgres://google_scrape@localhost:5432/google_scrape_dev rails s 
```
