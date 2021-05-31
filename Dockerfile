ARG VERSION=2.4.4
FROM gradiant/spark:$VERSION

ENV PYTHONPATH ${SPARK_HOME}/python/lib/pyspark.zip:${SPARK_HOME}/python/lib/py4j-src.zip

RUN apt-get update \
    && apt-get install -y python3 python3-pip python3-numpy python3-pandas python3-sklearn libboost-regex1.67.0 libboost-filesystem1.67.0 libboost-system1.67.0 \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install --no-cache-dir --upgrade pip setuptools \
    && pip3 install pyarrow==0.14.0 \
    && ln -s $SPARK_HOME/python/lib/py4j-*-src.zip $SPARK_HOME/python/lib/py4j-src.zip