FROM dockie/lamp
MAINTAINER Edgar Castanheda <edgar.castaneda@clicksandbricks.pe>

ADD src/ /var/www/html/
WORKDIR /var/www/html
RUN pwd && ls -laZ