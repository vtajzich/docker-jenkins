FROM vtajzich/java:oracle-java8

ENV JENKINS_HOME /jenkins

RUN apt-get update \
      && apt-get install -y sudo git \
      && rm -rf /var/lib/apt/lists/*

ADD http://updates.jenkins-ci.org/download/war/1.646/jenkins.war /opt/jenkins.war

VOLUME ["/jenkins"]

RUN chmod 644 /opt/jenkins.war

EXPOSE 8080
CMD ["java", "-jar", "/opt/jenkins.war"]
