FROM williamyeh/ansible:debian8-onbuild

RUN apt-get update && ansible-galaxy install HanXHX.dotdeb
CMD ["sh", "tests/test.sh", "php-7.0"]

