FROM ubuntu
MAINTAINER Anjaneyulu
RUN apt-get update && apt-get upgrade -y
RUN apt-get update
WORKDIR /root/
ENTRYPOINT [ "wget" ]
CMD ["echo","Hello Docker"] 
CMD ["--help"]


