FROM openjdk:8

WORKDIR /root
RUN apt-get update && apt-get install -y \
    iputils-ping \
    wget 

RUN  wget -q -O ycsb-mongo.tar.gz https://github.com/jedimt/ycsb/blob/master/ycsb-mongo.tar.gz?raw=true && tar zxf ycsb-mongo.tar.gz && rm ycsb-mongo.tar.gz

RUN apt remove wget -y && rm -rf /var/lib/apt/lists/*

#This section needs updating for Mongodb
#The end result of the command will be this string
#/root/ycsb-0.17.0/bin/ycsb load mongodb -s -P /root/ycsb-0.17.0/workloads/workloada -p mongodb.url=mongodb://mongo-0.mongo.mongodb.svc.cluster.local:27017/ycsb?w=0
ENV TYPE load
ENV DB mongodb

ENV WORKLOAD workloada
ENV THREADS 8
ENV RECORDCOUNT 10000000
ENV OPERATIONCOUNT 10000000

ENV HOST mongo-0.mongo.mongodb.svc.cluster.local
ENV PORT 27017

#This is temporary so I can get a console into the pod while troubleshooting things.
CMD ["/bin/bash", "-ec", "while :; do echo '.'; sleep 60 ; done"]

#CMD ["sh", "-c", "/root/ycsb-0.17.0/bin/ycsb ${TYPE} ${DB} \
#    -s -P /root/ycsb-0.17.0/workloads/${WORKLOAD} \
#    -threads ${THREADS} \
#    -p recordcount=${RECORDCOUNT} \
#    -p operationcount=${OPERATIONCOUNT} \
#    -p mongodb.url=mongodb://${HOST}:27017/ycsb?w=0"]
