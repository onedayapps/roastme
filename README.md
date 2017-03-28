# roastme
get roasted, son

## Setup

### Tools

Install the following

1. update your repo -> git pull
2. /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
3. brew install python
4. install pip -> https://pip.pypa.io/en/stable/installing/. download get-pip.py then run python get-pip.py
5. create ~/.bash_profile 
  -> touch ~/.bash_profile
  -> open -a TextEdit.app ~/.bash_profile
  -> Paste this into the file and save: 
  <ul>
    <li>export WORKON_HOME=$HOME/.virtualenvs</li>
    <li>export PROJECT_HOME=$HOME/Devel</li>
    <li>source /usr/local/bin/virtualenvwrapper.sh</li>
  </ul>
    
### Environment

1. pip install virtualenv 
2. pip install virtualenvwrapper
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
