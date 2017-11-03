sudo su
export BUILD_ENV=`cat /etc/env`
docker pull dkheyman/trial-repo:$BUILD_ENV
export NUM_CONTAINERS=`docker ps -q | wc -l | xargs`
echo $NUM_CONTAINERS
if [ $NUM_CONTAINERS != 0 ]; then docker stop $(docker ps -q); fi
docker run --rm -d -p 8080:8080 dkheyman/trial-repo:$BUILD_ENV
