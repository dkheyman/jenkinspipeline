FROM tomcat:7.0-jre7
MAINTAINER David Kheyman <david.kheyman@cloudreach.com>

ENV INSTALL_PATH /usr/local/tomcat
RUN mkdir -p $INSTALL_PATH/webapps
WORKDIR $INSTALL_PATH/webapps
COPY ./webapp/target/*.war .

VOLUME $INSTALL_PATH
