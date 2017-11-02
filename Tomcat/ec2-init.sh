#!/bin/bash
yum update -y &>> /tmp/output.log
yum install docker -y &>> /tmp/output.log
service docker start &>> /tmp/output.log
aws s3 cp s3://david-dockerbucket/ec2.pub /home/ec2-user/ec2.pub &>> /tmp/output.log
cat /home/ec2-user/ec2.pub >> ~/.ssh/authorized_keys
rm /home/ec2-user/ec2.pub
echo '$ENV ' >> /etc/env
