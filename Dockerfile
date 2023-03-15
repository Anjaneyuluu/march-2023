FROM ubuntu
MAINTAINER Anjaneyulu
RUN apt-get update && apt-get upgrade -y
RUN apt-get update
RUN apt-get install nodejs
RUN apt-get install mangodb
CMD ["echo","Hello Docker"] 


