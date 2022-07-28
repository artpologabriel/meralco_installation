# Meralco Registration Front End

sudo apt update

cd ~
curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh
sudo bash /tmp/nodesource_setup.sh
sudo apt install nodejs

# Manual installation: Create SSH key and publish to SSH keys in account Settings in Github
#ssh-keygen -t ed25519 -C meralco_dev
#cat ~/.ssh/id_ed25519.pub

#eval "$(ssh-agent -s)"
#ssh-add ~/.ssh/id_ed25519

#git clone git@github.com:artpologabriel/meralco_reg_backend.git



cd /opt

mkdir backend

cd backend

wget ithub.com:artpologabriel/meralco_installation/install_backend.zip

apt-get install unzip

unzip install_backend.zip -d /opt/backend

npm install

cp .env.example .env

sudo apt-get install -y mysql-server
sudo mysql

# Manual installation
CREATE USER 'meralco'@'localhost' IDENTIFIED BY '$Meralco2022';
GRANT ALL PRIVILEGES ON *.* TO 'meralco'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
SET SESSION sql_mode = 'NO_ENGINE_SUBSTITUTION'
SET GLOBAL sql_mode = 'NO_ENGINE_SUBSTITUTION';
\q

npx sequelize-cli db:create
npx sequelize-cli db:migrate
npx sequelize-cli db:seed:all

sudo npm install pm2 -g
sudo pm2 start index.js

sudo apt install -y nginx
sudo rm -rf /etc/nginx/sites-available/default
sudo cp default /etc/nginx/sites-available/default
sudo systemctl restart nginx