FROM google/debian:wheezy

ENV DEBIAN_FRONTEND noninteractive

ENV PROJECT_ID ****?

RUN apt-get update && apt-get install -y -qq --no-install-recommends wget unzip g++ python python-pip openssh-client python-openssl python-dev libffi-dev && apt-get clean

RUN pip install -U setuptools

RUN pip install pyopenssl ndg-httpsclient pyasn1

RUN pip install --upgrade urllib3
RUN pip install requests==2.7.0

RUN pip install dumb-init

RUN mkdir .ssh
RUN mkdir /slackbot
RUN mkdir /slackbot/servli
ENV PYTHONPATH $PYTHONPATH:/slackbot/servli

COPY test_config.json /slackbot/servli
COPY config.json /slackbot/servli
COPY fetchChannelId.py /slackbot/servli
COPY results.csv /slackbot/servli
COPY slackbotExercise.py /slackbot/servli
COPY tokens.py /slackbot/servli
COPY User.py /slackbot/servli
COPY user_cache.save /slackbot/servli
WORKDIR /slackbot/servli

CMD python slackbotExercise.py
