FROM openjdk:8-jre
MAINTAINER Alamgir Mohammed <alamgir99@gmail.com>
# create the whole path
RUN mkdir -p /usr/share/myapp/lib

ENTRYPOINT ["/usr/bin/java", "-jar", "/usr/share/myapp/my-app-1.0-SNAPSHOT.jar"]

# Add Maven dependencies (not shaded into the artifact; Docker-cached)
# ADD target/lib           /usr/share/myapp/lib
# Add the service itself
ARG JAR_FILE
ADD target/${JAR_FILE} /usr/share/myapp/

