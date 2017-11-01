sudo su
yum update -y
yum install docker -y
service docker start
docker pull dkheyman/trial-repo
docker run -p 8080:8080 dkheyman/trial-repo
