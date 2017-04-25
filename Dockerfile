FROM fedora:25

ENV JENKINS_HOME /jenkins

RUN dnf -y update && dnf -y install iputils net-tools wget openssh-server supervisor git sudo && mkdir ~/.ssh && chmod 400 ~/.ssh && dnf clean all

RUN mkdir -p /var/run/sshd
RUN mkdir -p /var/run/supervisord

ENV JAVA_VERSION 8u131
ENV BUILD_VERSION b11

RUN wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-$BUILD_VERSION/d54c1d3a095b4ff2b6607d096fa80163/jdk-$JAVA_VERSION-linux-x64.rpm" -O /tmp/jdk-8-linux-x64.rpm

RUN dnf -y install /tmp/jdk-8-linux-x64.rpm && rm /tmp/jdk-8-linux-x64.rpm

RUN alternatives --install /usr/bin/java java /usr/java/latest/bin/java 1
RUN alternatives --install /usr/bin/jar jar /usr/java/latest/bin/jar 1
RUN alternatives --install /usr/bin/javaws javaws /usr/java/latest/bin/javaws 1
RUN alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 1

ENV JAVA_HOME /usr/java/jdk1.8.0_131

ADD id_rsa /root/.ssh/
ADD id_rsa.pub /root/.ssh/

RUN chmod -R 400 /root/.ssh

ADD http://mirrors.jenkins-ci.org/war/2.56/jenkins.war /opt/jenkins.war

VOLUME ["/jenkins"]

RUN chmod 644 /opt/jenkins.war

ENV LC_ALL en_US.UTF-8

EXPOSE 8080 5005

CMD ["java", "-jar", "/opt/jenkins.war"]
