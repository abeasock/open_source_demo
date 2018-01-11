FROM centos

######################################################################################################
#
#   Vars
#
######################################################################################################

ARG JAVA_VER=java-1.8.0-openjdk-devel

ARG ANACONDA_URL=https://repo.continuum.io/archive/Anaconda2-5.0.0.1-Linux-x86_64.sh

ARG SPARK_URL=https://archive.apache.org/dist/spark/spark-2.2.0/spark-2.2.0-bin-hadoop2.7.tgz
ARG SPARK_VER=spark-2.2.0-bin-hadoop2.7

ARG ZEPPELIN_URL=https://archive.apache.org/dist/zeppelin/zeppelin-0.7.3/zeppelin-0.7.3-bin-all.tgz
ARG ZEPPELIN_VER=zeppelin-0.7.3-bin-all

ARG H2O_SPARKLING_WATER_URL=http://h2o-release.s3.amazonaws.com/sparkling-water/rel-2.2/6/sparkling-water-2.2.6.zip

######################################################################################################
#
#   Dependancies
#
######################################################################################################

RUN yum install -y ${JAVA_VER}
RUN echo "export JAVA_HOME=/usr/lib/jvm/java" >> /root/.bashrc

RUN yum install -y wget
RUN yum install -y unzip
RUN yum install -y net-tools
RUN yum install -y git

######################################################################################################
#
#   Install Spark
#
######################################################################################################

RUN wget ${SPARK_URL} --no-check-certificate -O /spark.tgz
RUN tar -xzvf spark.tgz
RUN mv ${SPARK_VER} /spark
RUN rm /spark.tgz

######################################################################################################
#
#   Install Zeppelin
#
######################################################################################################

RUN wget ${ZEPPELIN_URL} --no-check-certificate -O /zeppelin.tgz
RUN tar -xzvf zeppelin.tgz
RUN mv ${ZEPPELIN_VER} /zeppelin
RUN echo "export SPARK_HOME=/spark" >> /zeppelin/conf/zeppelin-env.sh
RUN echo 'export SPARK_SUBMIT_OPTIONS="--files /sparkling-water-2.2.6/py/build/dist/h2o_pysparkling_2.2-2.2.6.zip"' >> /zeppelin/conf/zeppelin-env.sh
RUN echo 'export PYTHONPATH="/sparkling-water-2.2.6/py/build/dist/h2o_pysparkling_2.2-2.2.6.zip:$SPARK_HOME/python:${SPARK_HOME}/python/lib/py4j-0.8.2.1-src.zip"' >> /zeppelin/conf/zeppelin-env.sh

RUN rm /zeppelin.tgz

######################################################################################################
#
#   Install Anaconda
#
######################################################################################################

RUN curl "https://bootstrap.pypa.io/get-pip.py" -k -o "get-pip.py"
RUN python get-pip.py --trusted-host pypi.python.org
RUN rm get-pip.py
RUN yum -y install bzip2
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet ${ANACONDA_URL} --no-check-certificate -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh

RUN opt/conda/bin/pip install tabulate 
RUN opt/conda/bin/pip install future 

######################################################################################################
#
#   Install Superset
#
######################################################################################################

RUN yum -y upgrade python-setuptools
RUN yum -y install python-setuptools
RUN yum -y install epel-release 
RUN yum -y install gcc gcc-c++ libffi-devel python-devel python-pip python-wheel openssl-devel libsasl2-devel openldap-devel

RUN pip install --upgrade setuptools pip
RUN pip install superset==0.22.1 --trusted-host pypi.python.org

RUN fabmanager create-admin --app superset --username admin --firstname admin --lastname user --email admin@fab.org --password admin
RUN superset db upgrade
RUN superset load_examples
RUN superset init

######################################################################################################
#
#   Install H2O Sparkling Water
#   $SPARK_HOME/bin/spark-shell --packages ai.h2o:sparkling-water-core_2.11:2.2.6
#
######################################################################################################

RUN wget ${H2O_SPARKLING_WATER_URL} --no-check-certificate -O /sparkling_water.zip
RUN unzip /sparkling_water.zip
RUN rm /sparkling_water.zip

#RUN pip install tabulate --trusted-host pypi.python.org
#RUN pip install future --trusted-host pypi.python.org
#RUN export SPARK_HOME=/spark
#RUN export MASTER="local[*]"

######################################################################################################
#
#   Assets
#
######################################################################################################

ADD assets /assets

######################################################################################################
#
#   Environmental Variables
#
######################################################################################################

ENV JAVA_HOME=/usr/lib/jvm/java
ENV SPARK_HOME=/spark
ENV PYTHONPATH=/sparkling-water-2.2.6/py/build/dist/h2o_pysparkling_2.2-2.2.6.zip:\$PYTHONPATH
ENV PYSPARK_PYTHON=/opt/conda/bin/python2.7


#CMD source /root/.bashrc; cd /spark; /zeppelin/bin/zeppelin-daemon.sh start; superset runserver