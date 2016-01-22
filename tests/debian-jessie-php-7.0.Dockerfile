FROM williamyeh/ansible:debian8-onbuild

RUN apt-get update
RUN ansible-galaxy install HanXHX.dotdeb
CMD ["sh", "tests/test.sh"]

