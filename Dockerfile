FROM vtajzich/java:oracle-java8

ENV JENKINS_HOME /jenkins

RUN apt-get update \
      && apt-get install -y sudo git \
      && rm -rf /var/lib/apt/lists/*

ADD http://mirrors.jenkins-ci.org/war/1.644/jenkins.war /opt/jenkins.war

VOLUME ["/jenkins"]

RUN chmod 644 /opt/jenkins.war

RUN locale-gen en_US.UTF-8

ENV LC_ALL en_US.UTF-8

EXPOSE 8080 5005

CMD ["java", "-jar", "/opt/jenkins.war"]
