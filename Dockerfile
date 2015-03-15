FROM ubuntu:trusty
MAINTAINER Piotr Zduniak <piotr@zduniak.net>

COPY local.cf /etc/mail/spamassassin/local.cf

RUN apt-get update -y && apt-get install spamassassin -y && apt-get clean -y && rm -rf /var/lib/apt-lists/*

RUN /etc/cron.daily/spamassassin

CMD /usr/sbin/spamd -x -i 0.0.0.0 -A 10.0.0.0/8,172.16.0.0/12,192.168.0.0/16,127.0.0.1/32 --max-children 5 --helper-home-dir -u mail -g mail -p 783

EXPOSE 783