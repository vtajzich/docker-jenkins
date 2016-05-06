FROM vtajzich/java:oracle-java8

ENV JENKINS_HOME /jenkins

RUN apt-get update \
      && apt-get install -y sudo git ssh \
      && rm -rf /var/lib/apt/lists/* \
      && mkdir ~/.ssh \
      && chmod 700 ~/.ssh

ADD id_rsa /root/.ssh/
ADD id_rsa.pub /root/.ssh/

RUN chmod 400 /root/.ssh/id_rsa

ADD http://mirrors.jenkins-ci.org/war/1.644/jenkins.war /opt/jenkins.war

VOLUME ["/jenkins"]

RUN chmod 644 /opt/jenkins.war

RUN locale-gen en_US.UTF-8

ENV LC_ALL en_US.UTF-8

EXPOSE 8080 5005

CMD ["java", "-jar", "/opt/jenkins.war"]
