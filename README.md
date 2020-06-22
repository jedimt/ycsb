# YCSB
Deploy the container 
`kubectl apply -k ./`

SSH into the container
`kubectl exec -it ycsb -n mongodb -- bash`

Run the workload:
`/root/ycsb-0.17.0/bin/ycsb load mongodb -s -P /root/ycsb-0.17.0/workloads/workloada -p mongodb.url=mongodb://mongo-0.mongo.mongodb.svc.cluster.local:27017/ycsb?w=0`

