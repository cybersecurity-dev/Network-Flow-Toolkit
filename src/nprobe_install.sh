# Update system package lists and install prerequisites
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y software-properties-common wget curl gnupg apt-transport-https

# Download and install the ntop repository package (choose your Ubuntu version, e.g., 22.04 or 24.04)
# For Ubuntu 22.04:
#wget https://packages.ntop.org/apt-stable/22.04/all/apt-ntop-stable.deb
#sudo apt-get install -y ./apt-ntop-stable.deb

# (Alternative for Ubuntu 24.04, uncomment if needed)
 wget https://packages.ntop.org/apt-stable/24.04/all/apt-ntop-stable.deb
 sudo apt-get install -y ./apt-ntop-stable.deb

# Update package lists and install nprobe
sudo apt-get update
sudo apt-get install -y nprobe
nprobe --version