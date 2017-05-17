# docker-webdev

The following compose is for use with nginx-proxy

example docker-compose.yml 

    version: "2"
    services:
        php:
            image: artdeptmj/webdev:xenial-wkhtml2pdf
            container_name: mysite
            expose:
                - 80
            networks:
                - dev_net1
                - dev_database
            volumes:
                - "./www:/var/www"
                - "./php.custom.ini:/etc/php/7.0/apache2/conf.d/php.custom.ini"
            environment:
              - VIRTUAL_HOST=$VHOST
    
    networks:
        dev_net1:
            external: true
        dev_database:
            external: true
            
example .env

    PROJECT_ROOT=./www
    VHOST=mysite.dev
    
example php.custom.ini

    memory_limit = 256M
    upload_max_filesize = 100M
    post_max_size = 100M
    
    xdebug.remote_enable = 1
    xdebug.remote_host = 10.0.75.1
    xdebug.max_nesting_level = 1000