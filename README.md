#OpenShift Origin JEE Simple Webapp
###Requirement
* Working Openshift Origin cluster
* MySQL Service running on Cluster 

###Parameters
* `HTTP_PROXY_HOST`: proxy host for maven
* `HTTP_PROXY_PORT`: proxy port for maven
* `MYSQL_SERVICE_HOST`: MySQL service host
* `MYSQL_SERVICE_PORT`: MySQL port
* `MYSQL_USER`: database username
* `MYSQL_PASSWORD`: database password
* `MYSQL_DATABASE`: database name

###Command
```
git clone https://github.com/anhnguyenbk/openshift-jee-webapp.git

oc new-app -f openshift-jee-webapp/openshift/template/jee-webapp.json \
-p HTTP_PROXY_HOST=<proxy_host>,HTTP_PROXY_PORT=<proxy_port>,\
MYSQL_SERVICE_HOST=<mysql_host>,MYSQL_SERVICE_PORT=<mysql_port>,\
MYSQL_USER=<username>,MYSQL_PASSWORD=<password>,MYSQL_DATABASE=<database>
```
