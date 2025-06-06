Ansible PHP (+FPM) role for Debian / Ubuntu
===========================================

[![Ansible Galaxy](http://img.shields.io/badge/ansible--galaxy-hanxhx.php-blue.svg)](https://galaxy.ansible.com/hanxhx.php) ![GitHub Workflow Status (master)](https://img.shields.io/github/actions/workflow/status/hanxhx/ansible-php/molecule.yml?branch=master)

Install PHP on Debian / Ubuntu. Manage PHP-FPM, APCu, Opcache and Xdebug.

Managed OS / Versions
---------------------

On all Debian versions, you can install all PHP versions (from PHP 5.6 to latest version) by using [Sury's APT repository](https://deb.sury.org/).

Links:
- [Sury](https://deb.sury.org/)

Requirements
------------

- Ansible >= 2.11
- Collections: [community.general](https://galaxy.ansible.com/community/general)
- If you need PHP-FPM, you must install a webserver with FastCGI support. You can use my [nginx role](https://github.com/HanXHX/ansible-nginx).

Role Variables
--------------

You should look at [default vars](defaults/main.yml).

### Writable vars

- `php_version`: 7.3, 7.4... depending on OS
- `php_install_fpm`: boolean, install and manage php-fpm (default is true)
- `php_install_xdebug`: boolean, install [Xdebug](http://xdebug.org)
- `php_extra_packages`: additional php packages to install (default is an empty list).

#### php.ini

- `php_ini`: global configuration shared beween FPM/CLI
- `php_ini_fpm`: manage FPM php.ini (php-fpm)
- `php_ini_cli`: manage CLI php.ini (php-fpm)

Note:

- If you want exactly same configuration for CLI/FPM. You can put all your data in `php_ini`.
- Put specific configuration in `php_ini_fpm`/`php_ini_cli`.
- You can override with `php_ini_fpm`/`php_ini_cli`, but it breaks idempotence.

#### OpCache settings

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

# Xdebug settings

See [Xdebug doc](http://xdebug.org/docs/all_settings)

- `php_xdebug_auto_trace`
- `php_xdebug_cli_color`
- `php_xdebug_collect_assignments`
- `php_xdebug_collect_includes`
- `php_xdebug_collect_params`
- `php_xdebug_collect_return`
- `php_xdebug_collect_vars`
- `php_xdebug_coverage_enable`
- `php_xdebug_default_enable`
- `php_xdebug_dump_globals`
- `php_xdebug_dump_once`
- `php_xdebug_dump_undefined`
- `php_xdebug_extended_info`
- `php_xdebug_file_link_format`
- `php_xdebug_force_display_errors`
- `php_xdebug_force_error_reporting`
- `php_xdebug_halt_level`
- `php_xdebug_idekey`
- `php_xdebug_manual_url`
- `php_xdebug_max_nesting_level`
- `php_xdebug_overload_var_dump`
- `php_xdebug_profiler_append`
- `php_xdebug_profiler_enable`
- `php_xdebug_profiler_enable_trigger`
- `php_xdebug_profiler_enable_trigger_value`
- `php_xdebug_profiler_output_dir`
- `php_xdebug_profiler_output_name`
- `php_xdebug_remote_autostart`
- `php_xdebug_remote_connect_back`
- `php_xdebug_remote_cookie_expire_time`
- `php_xdebug_remote_enable`
- `php_xdebug_remote_handler`
- `php_xdebug_remote_host`
- `php_xdebug_remote_log`
- `php_xdebug_remote_mode`
- `php_xdebug_remote_port`
- `php_xdebug_scream`
- `php_xdebug_show_exception_trace`
- `php_xdebug_show_local_vars`
- `php_xdebug_show_mem_delta`
- `php_xdebug_trace_enable_trigger`
- `php_xdebug_trace_enable_trigger_value`
- `php_xdebug_trace_format`
- `php_xdebug_trace_options`
- `php_xdebug_trace_output_dir`
- `php_xdebug_trace_output_name`
- `php_xdebug_var_display_max_children`
- `php_xdebug_var_display_max_data`
- `php_xdebug_var_display_max_depth`

### Read only vars

- `php_packages`: minimal package list to install
- `php_extension_dir.stdout`: get php extension dir (from task)
- `php_version.stdout`: get php version (from task)

Dependencies
------------

None.

Example Playbook
----------------

### Simple Playbook

```yaml
- hosts: servers
  roles:
     - { role: HanXHX.php }
```

### Debian Bullseye with PHP 8.0 CLI (no FPM)

```yaml
- hosts: servers
  roles:
     - { role: HanXHX.sury }
     - { role: HanXHX.php, php_version: '8.0', php_install_fpm: false }
```

License
-------

GPLv2

Donation
--------

If this code helped you, or if you’ve used them for your projects, feel free to buy me some :beers:

- Bitcoin: `1BQwhBeszzWbUTyK4aUyq3SRg7rBSHcEQn`
- Ethereum: `0x63abe6b2648fd892816d87a31e3d9d4365a737b5`
- Litecoin: `LeNDw34zQLX84VvhCGADNvHMEgb5QyFXyD`
- Monero: `45wbf7VdQAZS5EWUrPhen7Wo4hy7Pa7c7ZBdaWQSRowtd3CZ5vpVw5nTPphTuqVQrnYZC72FXDYyfP31uJmfSQ6qRXFy3bQ`

No cryptocurrency? :star: the project is also a way of saying thank you! :sunglasses:

Author Information
------------------

- Twitter: [@hanxhx_](https://twitter.com/hanxhx_)
