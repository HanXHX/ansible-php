Ansible PHP (+FPM) role for Debian
==================================

[![Build Status](https://travis-ci.org/HanXHX/ansible-php.svg)](https://travis-ci.org/HanXHX/ansible-php)

Install PHP (php-fpm optional) on Debian Wheezy/Jessie. Depending of your PHP version: manage APC(u) / Opcache.

Requirements
------------

If you need PHP-FPM, you must install a webserver with FastCGI support. You can use my [nginx role](https://github.com/HanXHX/ansible-nginx).
On Debian Wheezy, you can use many PHP version: 5.4 from Debian repository and 5.5/5.6 from [Dotdeb](https://www.dotdeb.org). With my [dotdeb role](https://github.com/HanXHX/ansible-debian-dotdeb), you can choose which version you want.

Role Variables
--------------

You should look at [default vars](defaults/main.yml).

### Writable vars

- `php_install_fpm`: boolean, install and manage php-fpm (default is true)
- `php_extra_packages`: additional php packages to install (default is an empty list).
- `php_ini`: manage php.ini (php-fpm), as key/value.


#### OpCache settings (PHP >= 5.5)

See [Opcache doc](https://secure.php.net/manual/en/opcache.configuration.php)

- `php_opcache_enable`
- `php_opcache_enable_cli`
- `php_opcache_memory_consumption`
- `php_opcache_interned_strings_buffer`
- `php_opcache_max_accelerated_files`
- `php_opcache_max_wasted_percentage`
- `php_opcache_validate_timestamps`
- `php_opcache_revalidate_freq`
- `php_opcache_max_file_size`


#### APC/APCu settings

See [apc doc](https://secure.php.net/manual/en/apc.configuration.php)

- `php_apc_enable`
- `php_apc_enable_cli`
- `php_apc_shm_size`
- `php_apc_num_files_hint`
- `php_apc_user_entries_hint`
- `php_apc_user_ttl`
- `php_apc_ttl`
- `php_apc_file_update_protection`
- `php_apc_slam_defense`
- `php_apc_stat_ctime`


### Read only vars

- `php_packages`: minimal package list to install

Dependencies
------------

None.

Example Playbook
----------------

### Simple Playbook

    - hosts: servers
      roles:
         - { role: HanXHX.php }

### Debian Wheezy with PHP 5.5

    - hosts: wheezy-servers
      roles:
         - { role: HanXHX.dotdeb, dotdeb_php_version: "5.5" }
         - { role: HanXHX.php }

License
-------

GPLv2

Author Information
------------------

- You can find many other roles in my GitHub "lab": https://github.com/HanXHX/my-ansible-playbooks
- All issues, pull-request are welcome :)

