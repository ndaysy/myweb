FROM tomcat:8.5.51.ai.1

ADD myweb.war /usr/local/tomcat/webapps/

EXPOSE 8080
CMD ["catalina.sh", "run"]
