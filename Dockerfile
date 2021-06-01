FROM bitnami/spark:2.4.6

USER root

RUN pip install wheel && \
    pip3 install \
    pyspark=2.4.6 \
    pyarrow==0.14