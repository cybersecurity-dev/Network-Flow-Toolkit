# Install build tools and required dependency headers
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y build-essential pkg-config libglib2.0-dev libpcap-dev libpcre3-dev wget

# 1. Download and install libfixbuf (the IPFIX protocol library required by YAF)
wget https://tools.netsa.cert.org/releases/libfixbuf-2.4.2.tar.gz
tar -xvzf libfixbuf-2.4.2.tar.gz
cd libfixbuf-2.4.2
./configure --prefix=/usr
make
sudo make install
cd ..

# 2. Download, build, and install YAF
wget https://tools.netsa.cert.org/releases/yaf-2.14.0.tar.gz
tar -xvzf yaf-2.14.0.tar.gz
cd yaf-2.14.0
./configure --prefix=/usr --enable-applabel --enable-plugins
make
sudo make install
cd ..

# Update shared library links
sudo ldconfig

sudo apt-get install -y softflowd

# Verify Installations
yaf --version