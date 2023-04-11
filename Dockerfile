FROM        ubuntu
MAINTAINER  cbhays@reed.edu

# update and install basic tool-chain dependencies
RUN         apt-get update \
  	 && apt-get install -y \
		build-essential \
		gdb \
		cmake \
		git \
		curl \
		vim \
		git \
		zlib1g \
		zlib1g-dev

# clone charm and build it with a shared-memory configuration, i.e., multicore
RUN	    cd /usr/local/src \
            	&& git clone https://github.com/UIUC-PPL/charm.git charm \
		&& cd charm \
		&& ./build ChaNGa multicore-linux-x86_64 --with-production 

# clone changa and utility within the charm directory
RUN	    cd /usr/local/src/charm \
		&& git clone https://github.com/N-BodyShop/changa.git changa \
		&& git clone https://github.com/N-BodyShop/utility.git utility

# build changa
RUN	    cd /usr/local/src/charm/changa \
		&& ./configure  \
		&& make

# run testcosmo to validate the image is operational
# RUN	    cd /usr/local/src/charm/changa/testcosmo \
#		&& ./run.sh
#

# create a user account so they don't need to run as root
# RUN	    TBD


