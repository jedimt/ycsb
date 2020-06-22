#To Do
# Figure out how to slim down image more, still at 907MB compressed
# Might look at deleting cruft from the ycsb install
# Fix the command '/bin/sh -c wget -q https://github.com/jedimt/ycsbtemp/blob/master/ycsb-mongo.tar.gz' returned a non-zero code: 8


FROM openjdk:8

WORKDIR /root
RUN apt-get update && apt-get install -y \
    iputils-ping \
    wget \
    gzip

#RUN wget -q https://github.com/brianfrankcooper/YCSB/releases/download/0.17.0/ycsb-0.17.0.tar.gz && tar zxf ycsb-0.17.0.tar.gz && rm ycsb-0.17.0.tar.gz
RUN wget -q https://github.com/jedimt/ycsbtemp/blob/master/ycsb-mongo.tar.gz

#The following command fails saying that the archive is not valid
#Look into using gunzip maybe then tar?
#Also, test just downloading the file locally back to the laptop from github to make sure its still valid after the transfer
RUN tar -zxvf /root/ycsb-mongo.tar.gz
RUN rm /root/ycsb-mongo.tar.gz

#WORKDIR /root/ycsb-0.17.0
#RUN ls | grep binding | grep -v mongodb-binding | xargs rm -rf
#WORKDIR /root

RUN apt remove wget -y && rm -rf /var/lib/apt/lists/*

ENV TYPE load
ENV DB mongodb

ENV WORKLOAD workloada
ENV THREADS 4
ENV RECORDCOUNT 10000000
ENV OPERATIONCOUNT 10000000

ENV HOST mongo-0.mongo.mongodb.svc.cluster.local
ENV PORT 27017

# CMD ["/bin/bash"]

#CMD ["sh", "-c", "/root/ycsb-0.17.0/bin/ycsb ${TYPE} ${DB} \
#    -P /root/ycsb-0.17.0/workloads/${WORKLOAD} \
#    -threads ${THREADS} \
#    -p recordcount=${RECORDCOUNT} \
#    -p operationcount=${OPERATIONCOUNT} \
#    -p host=${HOST} \
#    -p port=${PORT}"]