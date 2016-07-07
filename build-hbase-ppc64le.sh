#!/bin/bash
set -ex
mkdir jruby; cd jruby
wget  https://github.com/ibmsoe/jruby/releases/download/1.6.8/jruby-complete-1.6.8.jar
mvn install:install-file -Dfile=jruby-complete-1.6.8.jar -DgroupId=org.jruby -DartifactId=jruby-complete -Dversion=1.6.8 -Dpackaging=jar
cd ..
rm -rf jruby

export MAVEN_OPTS="-Xmx512m -XX:MaxPermSize=128m"
HADOOP_VERSION=2.7.1-ppc64le
ZOOKEEPER_VERSION=3.4.5

mvn -DskipTests -Dslf4j.version=1.6.1         \
    -Dhadoop-two.version=$HADOOP_VERSION      \
    -Dzookeeper.version=$ZOOKEEPER_VERSION    \
     clean install assembly:single "$@"
#    site assembly:single "$@"
#rm -rf build
#mkdir build
#tar -C build --strip-components=1 -xzf hbase-assembly/target/hbase*.tar.gz
