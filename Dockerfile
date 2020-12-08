# take the latest version of ubuntu docker image
FROM ubuntu

#setting env variable
ENV DEBIAN_FRONTEND=non-interactive

#update apt indexes of the repo 
RUN apt-get update -y

#installing required applications from apt repos
RUN apt-get install -y git curl apache2 php libapache2-mod-php php-mysql

# removing the contents under the default html directory
RUN rm -rf /var/www/html/*

#adding the source into html
ADD src /var/www/html/

# enable apache rewrite module
RUN a2enmod rewrite

#change the ownership recursively under the html directory
RUN chown -R www-data:www-data /var/www/html

#setting up default env variables for apache
ENV APACHE_RUN_DIR /var/www/html
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

#docker to use port 8085
EXPOSE 8085

#command to execute when docker image is run
CMD ["/usr/sbin/apache2", "-D",  "FOREGROUND"]
