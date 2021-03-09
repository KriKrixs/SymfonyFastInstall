#!/bin/bash

# APT Update
echo "APT Update"
sudo apt update -qq
sudo apt install -y -qq curl
echo "APT Update OK"

# Node Version Manager installation
echo "Node Version Manager installation"
wget https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh
source install.sh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
echo "Node Version Manager OK"

# Reload session
echo "Reload session"
source ~/.profile
source ~/.bashrc
echo "Reload OK"

# Install latest LTS Node.JS version
echo "Install latest LTS Node.JS version"
nvm install --lts
echo "Node OK"

# Add SURY PHP PPA repository
echo "Add SURY PHP PPA repository"
sudo apt -y -qq install lsb-release apt-transport-https ca-certificates
sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
echo "Repo OK"

# Install PHP 7.4
echo "Install PHP 7.4"
sudo apt update -qq
sudo apt -y -qq install php7.4
echo "PHP 7.4 OK"

# Install Composer
echo "Install Composer"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3' { echo 'Composer installer verified'; } else { echo 'Composer installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
if [ -e composer.phar ]
then
	echo "Composer OK"
else
	echo "Composer Not OK"
	exit
fi

echo "Move Composer Globally"
sudo mv composer.phar /usr/local/bin/composer
echo "Global Composer OK"

# Install latest version of Symfony
echo "Install latest Symfony version"
wget https://get.symfony.com/cli/installer
source installer
sudo mv ~/.symfony/bin/symfony /usr/local/bin/symfony
echo "Symfony OK"

# Reload session
echo "Reload session"
source ~/.profile
source ~/.bashrc
echo "Reload OK"

# Install all symfony requirements
echo "Install all symfony requirements"
sudo apt install -y php7.4-{xml,dom,mbstring,intl,mysql}
echo "Symfony requirements OK"

# Clearing symfony installation file
echo "Clear Symfony installation file"
rm installer
echo "Clear OK"

# Thanks
echo -e "\n\nThanks for using my script\nIf you have any feedback, feel free to add me on discord: OMDN | Krixs#1106"
