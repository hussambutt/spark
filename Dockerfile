FROM bitnami/spark:2.4.6

USER root

ARG version=3.2.2
ENV HADOOP_VERSION=$version \
    HADOOP_PREFIX=/opt/hadoop \
    HADOOP_HOME=/opt/hadoop \
    HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop \
    PATH=$PATH:/opt/hadoop/bin \
    MULTIHOMED_NETWORK=1 \
    CLUSTER_NAME=hadoop \
    HDFS_CONF_dfs_namenode_name_dir=file:///dfs/name \
    HDFS_CONF_dfs_datanode_data_dir=file:///dfs/data \
    USER=hdfs

RUN apt-get update && apt-get install -y curl procps && rm -rf /var/lib/apt/lists/* && \
    curl -SL https://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz | tar xvz -C /opt && \
    ln -s /opt/hadoop-$HADOOP_VERSION /opt/hadoop && \
    # remove documentation from container image
    rm -r /opt/hadoop/share/doc && \
    if [ ! -f $HADOOP_CONF_DIR/mapred-site.xml ]; then \
    cp $HADOOP_CONF_DIR/mapred-site.xml.template $HADOOP_CONF_DIR/mapred-site.xml; \
    fi && \
    groupadd -g 114 -r hadoop && \
    useradd --comment "Hadoop HDFS" -u 201 --shell /bin/bash -M -r --groups hadoop --home /var/lib/hadoop/hdfs hdfs && \
    mkdir -p /dfs && \
    mkdir -p /opt/hadoop/logs && \
    chown -R hdfs:hadoop /dfs && \
    chown -LR hdfs:hadoop /opt/hadoop

RUN pip install wheel && \
    pip3 install \
    pyspark==2.4.8 \
    pyarrow==0.14