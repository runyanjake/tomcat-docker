FROM tomcat:latest

COPY builds/ROOT.war /usr/local/tomcat/webapps

