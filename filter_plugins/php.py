def php_socket(php_version, pool_name):
    return '/run/php/php%s-%s-fpm.sock' % (php_version, pool_name)

class FilterModule(object):
    ''' PHP module '''

    def filters(self):
        return {
            'php_socket': php_socket,
        }
