# Tomcat, Dockerized

I'm just dockerizing a tomcat that runs a WAR file built by a maven project.

### Setup

1. Install Maven

`sudo apt install maven`

2. Create new maven project.

`mvn archetype:generate -DgroupId=com.helloworld.app -DartifactId=hello-world -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false`

3. Package the project into a JAR file and run it. 

`mvn package`

`java -cp target/hello-world-1.0-SNAPSHOT.jar com.helloworld.app.App`

### Configure project to generate WAR file.

Add the Maven WAR plugin to the POM. Configure it to include webResources if necessary. Else just include the plugin definition.

```
<plugin>
    <artifactId>maven-war-plugin</artifactId>
    <version>3.3.1</version>
</plugin>
``` 

Additionally, we have to add in the top level pom an instruction to build to a war file.

`<packaging>war</packaging>`

Also, we must create a WEB-INF folder + web.xml and point to it in our war plugin definition. So after creating the file `hello-world/src/main/WEB-INF/web.xml`, the final war plugin config looks like:

```
<plugin>
  <groupId>org.apache.maven.plugins</groupId>
  <artifactId>maven-war-plugin</artifactId>
  <version>3.3.1</version>
  <configuration>
    <webXml>src/main/WEB-INF/web.xml</webXml>
  </configuration>
</plugin>
```

### Dockerize

Dockerfile is configured to copy in `ROOT.war` from the top level of this repo. So once WAR file is ready for deployment, copy it from `hello-world/target/hello-world-x.x-SNAPSHOT.war` to the top level as `ROOT.war`.

Build with the included docker-compose.

### New Rest Endpoint Module

1. Create new module to house the endpoint.

`mvn archetype:generate -DgroupId=com.helloworld.helloendpoint  -DartifactId=hello-endpoint`


