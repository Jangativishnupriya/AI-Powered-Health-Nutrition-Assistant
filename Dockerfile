FROM tomcat:11.0.27-jdk25-temurin-noble

RUN rm -rf /usr/local/tomcat/webapps/*

COPY HealthCareSystem.war /usr/local/tomcat/webapps/ROOT.war

CMD ["/bin/sh", "-c", "sed -i \"s/port=\\\"8080\\\"/port=\\\"${PORT:-8080}\\\"/\" /usr/local/tomcat/conf/server.xml && exec catalina.sh run"]