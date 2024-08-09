# Celery demo

Small demo to get started with `Celery` using `Redis` as broker and `Postgres` as backend for persistency. `Redis` and `Postgres` will be running locally on Docker containers and every Python dependecy for `Celery` is best configured on a virtual environment (there is a docker container for Celery but its deprecated)

## Dependecies 
- Docker
- Python 3.xx.x
- pip

### Python modules
There are couple of modules required to get things going. Ideally you would set this up in a new Virtual environment to isollate this demo from your global config. You can follow these steps to setup the enviornment and install deps using pip

Create venv:
```console
$ python3 -m venv desired/path/to/your/new/venv
```

Strat venv:
```console
$ source desired/path/to/your/new/venv/bin/activate
```
Install deps:
```console
$ pip install celery
$ pip install -U "celery[redis]" 
$ pip install psycopg2
```
> If you get an error saying that `pg_config` is missing when installing `psycopg2` this is because there are some dependicies related to postgres that are not installed on your system. In Linux (Ubuntu specifically) it was fixed by installing `libpq-dev` package

## Setting up local Docker environment
First pull images for `Redis` and `Postgres`. 

```console
$ docker pull redis
$ docker pull postgress
```

Then run the containers:

Redis:
```console
$ docker run --name my-redis -d \
    -p 6379:6379 \
    redis
```

Postgres: 
```console
$ docker run --name my-postgres -d \
    -e POSTGRES_PASSWORD=adminpwd \
    -e POSTGRES_USER=test \
    -e POSTGRES_DB=test \
	-p 5432:5432 \
    postgres
```
## Running Celery
After all deps are installed and containers are running open up a terminal and run:

```console
$ celery -A tasks worker --loglevel=info
```

This will start the Celery worker on your machine and it will wait for a job to run a task.

To run a task you can openup a new terminal, navigate to the path to the `tasks.py` file on this repo and run the `reverse` method:
```console
$ python3
Type "help", "copyright", "credits" or "license" for more information.
>>> from tasks import reverse
>>> result = reverse.delay ('some_string')
```

The reverse method will simple reverse whatever string you pass to it but the purpose of this is to go back to the terminal where you started Celery and look at how the worker process the task. Once finished you can run it a couple more times to create more entries on the DB and then actually check the tables to look at the tasks stored in Postgres

To run a query against the DB you can login by running the following command:

```console
$ docker exec -ti my-postgres psql -U test
```

and then list the tables `\dt`, you should see something similar to this:

```console
               List of relations
 Schema |        Name        | Type  |  Owner
--------+--------------------+-------+----------
 public | celery_taskmeta    | table | test
 public | celery_tasksetmeta | table | test
(2 rows)
```

The `celery_taskmeta` table is where Celery will store the tasks, you can query them by running:

```console
test=# SELECT * FROM celery_tasksetmeta;
```

You should see something similar to this:

```console
 id |               task_id                | status  |                    result                    |         date_done          | traceback | name | args | kwargs | worker | retries | queue
----+--------------------------------------+---------+----------------------------------------------+----------------------------+-----------+------+------+--------+-
  1 | aa71596b-fdfe-41a1-bbcb-ccf85e9f822a | SUCCESS | \x8005950a000000000000008c0673616974614d942e | 2024-08-09 19:27:24.494645 |           |      |      |        |        |         |
  2 | 9e72675a-d480-4a44-891d-1ac68fc9158b | SUCCESS | \x80059509000000000000008c056f72646550942e   | 2024-08-09 19:34:40.375484 |           |      |      |        |        |         |
(2 rows)
```
