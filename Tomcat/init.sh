sudo su
docker pull dkheyman/trial-repo:$BUILD_ENV
docker run -p 8080:8080 dkheyman/trial-repo:$BUILD_ENV
