FROM williamyeh/ansible:debian8-onbuild

RUN apt-get update
CMD ["sh", "tests/test.sh", "5.6"]

