# Meralco Registration Front End

sudo apt update

cd ~
curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh
sudo bash /tmp/nodesource_setup.sh
sudo apt install nodejs

# Create SSH key and publish to SSH keys in account Settings in Github
# ssh-keygen -t ed25519 -C meralco_dev
# cat ~/.ssh/id_ed25519.pub


# eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/id_ed25519

# git clone git@github.com:artpologabriel/meralco_reg_frontend.git

# cd meralco_reg_frontend

cd /opt

mkdir frontend

cd frontend

wget ithub.com:artpologabriel/meralco_installation/install_frontend.zip

apt-get install unzip

unzip install_frontend.zip -d /opt/backend

npm install


cp .env.example .env

npm install
npm run build
sudo chown -R www-data:ubuntu dist/
sudo gpasswd -a www-data ubuntu

sudo apt install -y nginx
sudo rm -rf /etc/nginx/sites-available/default
sudo cp default /etc/nginx/sites-available/default
sudo systemctl restart nginx
sudo nginx -t
sudo cat /var/log/nginx/error.log
