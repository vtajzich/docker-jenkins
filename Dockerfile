FROM vtajzich/java:oracle-java8

ENV JENKINS_HOME /jenkins

USER root

RUN useradd -d "$JENKINS_HOME" -u 1000 -m -s /bin/bash jenkins

RUN apt-get update \
      && apt-get install -y sudo git \
      && rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

USER jenkins

ADD http://mirrors.jenkins-ci.org/war/1.644/jenkins.war /opt/jenkins.war

VOLUME ["/jenkins"]

RUN sudo chmod 644 /opt/jenkins.war


EXPOSE 8080
CMD ["java", "-jar", "/opt/jenkins.war"]
