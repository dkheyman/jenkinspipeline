sudo su
export BUILD_ENV=`cat /etc/env`
docker pull dkheyman/trial-repo:$BUILD_ENV
docker stop $(docker ps -q)
docker rm $(docker ps -a -q)
docker run --rm -d -p 8080:8080 dkheyman/trial-repo:$BUILD_ENV
