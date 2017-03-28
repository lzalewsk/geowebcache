FROM tomcat:8.5-jre8
MAINTAINER luka

ENV DEBIAN_FRONTEND noninteractive
ENV _POSIX2_VERSION 199209

RUN  echo "deb http://httpredir.debian.org/debian jessie non-free" >> /etc/apt/sources.list     && apt-get update     && apt-get install -y apt-utils     && apt-get install -y libjai-core-java libjai-imageio-core-java
#&& rm -rf /var/lib/apt/lists/

# jai + imageio:
RUN ln -s /usr/share/java/jai_core.jar /usr/local/tomcat/lib/jai_core.jar &&     ln -s /usr/share/java/jai_codec.jar /usr/local/tomcat/lib/jai_codec.jar &&     ln -s /usr/share/java/mlibwrapper_jai.jar /usr/local/tomcat/lib/mlibwrapper_jai.jar &&     ln -s /usr/share/java/jai_imageio.jar /usr/local/tomcat/lib/jai_imageio.jar &&     ln -s /usr/share/java/clibwrapper_jiio.jar /usr/local/tomcat/lib/clibwrapper_jiio.jar

#RUN wget -O /tmp/geowebcache.zip https://sourceforge.net/projects/geowebcache/files/geowebcache/1.8.3/geowebcache-1.8.3-war.zip/download     && unzip /tmp/geowebcache.zip -d /tmp/     && unzip /tmp/geowebcache.war -d /opt/geowebcache     && rm /tmp/geowebcache.zip && rm /tmp/geowebcache.war
RUN wget -O /tmp/geowebcache.zip https://sourceforge.net/projects/geowebcache/files/geowebcache/1.11.0/geowebcache-1.11.0-war.zip/download     && unzip /tmp/geowebcache.zip -d /tmp/     && unzip /tmp/geowebcache.war -d /opt/geowebcache     && rm /tmp/geowebcache.zip && rm /tmp/geowebcache.war

ADD geowebcache_context.xml /usr/local/tomcat/conf/Catalina/localhost/geowebcache.xml

# SET geowebcache.xml location to /config
RUN mkdir /config && chmod a+rw /config     && sed -i.bak "1,20 s/<constructor-arg ref=\"gwcDefaultStorageFinder\" \/>/<constructor-arg value=\"\/config\" \/>/g" /opt/geowebcache/WEB-INF/geowebcache-core-context.xml

# Clean
RUN rm -rf /var/lib/apt/lists/

# SET CACHE_DIR
RUN mkdir /cache && chmod a+rw /cache
ENV GEOWEBCACHE_CACHE_DIR /cache

VOLUME /config /cache

