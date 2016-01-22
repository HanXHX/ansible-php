FROM williamyeh/ansible:debian8-onbuild

RUN apt-get update
CMD ["sh", "tests/test.sh", "php-5.6"]

