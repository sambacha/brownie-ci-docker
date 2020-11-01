# vim:set ft=dockerfile:

FROM cimg/base:2020.06

SHELL ["/bin/bash", "-c"]

LABEL maintainer="Community Engineering <gitr@yfinance.dev>"

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'


ENV PYENV_ROOT=/home/circleci/.pyenv \
	PATH=/home/circleci/.pyenv/shims:/home/circleci/.pyenv/bin:/home/circleci/.poetry/bin:$PATH


RUN useradd -m circleci
USER circleci

WORKDIR /home/circleci/

# segregate the base apt packages from python3's needed deps.
RUN apt-get -qq update && \
    apt-get -qq -y --no-install-recommends install build-essentia gnupg software-properties-common linux-tools-common && \
    ca-certificates locales sudo ca-certificates wget curl && \
    locale-gen en_US.UTF-8 && \
    apt-get -qq -y purge gnupg software-properties-common curl && \
    apt -y autoremove

# leave install recommends for now
RUN sudo apt-get update && sudo apt-get install -y -qq \
		git \
		libbz2-dev \
		liblzma-dev \
		libncurses5-dev \
		libncursesw5-dev \
		libreadline-dev \
		libffi-dev \
		libsqlite3-dev \
		libssl-dev \
		libxml2-dev \
		libxmlsec1-dev \
		llvm \
		make \
		python-openssl \
		tk-dev \
		xz-utils \
		jq \
		openssh-client \
		libpq-dev \
		unzip \
		zlib1g-dev && \
	curl https://pyenv.run | bash && \
	sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pyenv install 3.7.9 && pyenv global 3.7.9

RUN python --version && \
	pip --version && \
	# This installs pipenv at the latest version, currently 2020.6.2
	pip install pipenv wheel

# This installs version poetry at the latest version. poetry is updated about twice a month.
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python

RUN curl -sSL "https://raw.githubusercontent.com/CircleCI-Public/cimg-node/master/ALIASES" -o nodeAliases.txt && \
	NODE_VERSION=$(grep "lts" ./nodeAliases.txt | cut -d "=" -f 2-) && \
	curl -L -o node.tar.xz "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz" && \
	sudo tar -xJf node.tar.xz -C /usr/local --strip-components=1 && \
	rm node.tar.xz nodeAliases.txt && \
	sudo ln -s /usr/local/bin/node /usr/local/bin/nodejs

ENV YARN_VERSION 1.22.4
RUN curl -L -o yarn.tar.gz "https://yarnpkg.com/downloads/${YARN_VERSION}/yarn-v${YARN_VERSION}.tar.gz" && \
	sudo tar -xzf yarn.tar.gz -C /opt/ && \
	rm yarn.tar.gz && \
	sudo ln -s /opt/yarn-v${YARN_VERSION}/bin/yarn /usr/local/bin/yarn && \
	sudo ln -s /opt/yarn-v${YARN_VERSION}/bin/yarnpkg /usr/local/bin/yarnpkg



RUN python3 setup.py install --user
ENV PATH="/home/slither/.local/bin:${PATH}"
CMD /bin/bash

ENV PATH=/var/lang/bin:$PATH \
    LD_LIBRARY_PATH=/var/lang/lib:$LD_LIBRARY_PATH \
    AWS_EXECUTION_ENV=AWS_Lambda_python3.6 \
    PKG_CONFIG_PATH=/var/lang/lib/pkgconfig:/usr/lib64/pkgconfig:/usr/share/pkgconfig \
    PIPX_BIN_DIR=/var/lang/bin \
    PIPX_HOME=/var/lang/pipx

RUN  pip install pipx --no-cache-dir --user pipx && \
     pipx install virtualenv && \
     pipx install pipenv && \
     pipx install poetry==1.1.4 && \
     pipx install awscli==1.* && \
     pipx install aws-lambda-builders==1.1.0 && \
     pipx install aws-sam-cli==1.7.0 \
	 python3 -m pipx ensurepath

RUN pipx install eth-brownie 
#    pipx upgrade eth-brownie

USER brownie
WORKDIR /brownie-ci

EXPOSE 80/tcp
EXPOSE 80/udp

RUN ["/bin/bash", "-c", "brownie --help"]
