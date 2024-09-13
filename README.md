docker build -t ashafqat/edb-lasso:v1.9 .
docker login
docker push ashafqat/edb-lasso:v1.9

Modify your company id and token in /etc/edb-lasso.conf. You can find both values in EDB Support portal, company page https://techsupport.enterprisedb.com/company. 

[customer]
id=
token=

Once the pod is up and running, run below commands to generate lasso report
cd /tmp
lasso -H IP_ADDRESS -p PORT --password PASSWORD DATABASE_NAME USER_NAME

Copy report from pod to local computer. Upload it with the ticket