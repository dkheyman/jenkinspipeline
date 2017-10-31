sudo su
rsync /tmp/*.war /var/lib/tomcat7/webapps/
chown tomcat /var/lib/tomcat7/webapps /var/lib/tomcat7/webapps/*.war
