# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node.
FROM ubuntu:16.04
MAINTAINER Derek Pedersen <derekpedersen.contact@gmail.com>

# update the apt repositories
RUN apt-get update -y

# get ubuntu things
RUN apt-get install -y software-properties-common

# need the latest golang
RUN add-apt-repository ppa:gophers/archive

# update the apt repositories
RUN apt-get update -y

# Install a basic SSH server
RUN apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd

# Install JDK 7 (latest edition)
RUN apt-get install -y --no-install-recommends default-jdk

# Install utilities
RUN apt-get install -y git wget curl python-virtualenv python-pip build-essential python-dev
RUN apt-get install -y mysql-client
RUN apt-get install -y golang-go
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install -y nodejs
RUN nodejs -v
RUN npm -v
RUN apt-get install -y build-essential

RUN export JAVA_HOME=’/usr/lib/jvm/jre-1.8.0-openjdk’
RUN export JRE_HOME=’/usr/lib/jvm/java-8-openjdk-amd64/jre’

# Add user jenkins to the image
RUN adduser --quiet jenkins

# Add user jenkins to sudoers with NOPASSWD
RUN echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set password for the jenkins user (you may want to alter this).
RUN echo "jenkins:jenkins" | chpasswd

# Setting for sshd
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd  

# Standard SSH port
EXPOSE 22
EXPOSE 50000

CMD [ "java -jar slave.jar -jnlpUrl http://10.27.249.51:8080/computer/jnlp-p30g4/slave-agent.jnlp -secret f85585403aff9c45e661c4086b54c77c46e894ed6a1ebf2b513a3c3060075f36" ]
CMD ["/usr/sbin/sshd", "-D"]