FROM bitnami/spark:2.4.6

USER root
RUN pip3 install pyarrow==0.14.0 \
    && pip3 install pyspark==2.4.6