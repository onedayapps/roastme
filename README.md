# roastme
get roasted, son

## Setup

### Environment

1. Install virtualenv and virtualenvwrapper
2. `mkvirtualenv roastme`
3. `workon roastme`
4. sudo pip install -r requirements.txt

### Database

1. Install postgresql: `brew install postgresql`
2. `createdb roastme`
3. `psql -d roastme`
4. `CREATE USER roastmedev WITH PASSWORD 'getroastedson';`
5. `GRANT ALL PRIVILEGES ON DATABASE roastme to roastmedev;`

### Setup Django Web Server

1. `python manage.py migrate`
2. `python manage.py runserver ip:port`
