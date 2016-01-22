#!/bin/sh

# Thanks to https://servercheck.in/blog/testing-ansible-roles-travis-ci-github

DIR=$( dirname $0 )
INVENTORY_FILE="$DIR/inventory"
PLAYBOOK="$DIR/test.yml"
ANSIBLE_ARG=""

set -ev

# Only for travis
if [ -n "$1" ]
then
	ANSIBLE_ARG="--extra-vars 'php_version=$1'"
fi


ansible --version

# Check syntax
ansible-playbook -i $INVENTORY_FILE -c local $ANSIBLE_ARG --syntax-check -vv $PLAYBOOK

# Check role
ansible-playbook -i $INVENTORY_FILE -c local $ANSIBLE_ARG --become -vv $PLAYBOOK

# Check indempotence
ansible-playbook -i $INVENTORY_FILE -c local $ANSIBLE_ARG --become -vv $PLAYBOOK \
| grep -q 'changed=0.*failed=0' \
&& (echo 'Idempotence test: pass' && exit 0) \
|| (echo 'Idempotence test: fail' && exit 1)
