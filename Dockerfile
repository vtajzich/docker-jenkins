FROM vtajzich/java:oracle-java8

RUN apt-get update && \
    apt-get install -y git
ADD http://mirrors.jenkins-ci.org/war/1.644/jenkins.war /opt/jenkins.war

VOLUME ["/jenkins"]

RUN chmod 644 /opt/jenkins.war
ENV JENKINS_HOME /jenkins

EXPOSE 8080
CMD ["java", "-jar", "/opt/jenkins.war"]
