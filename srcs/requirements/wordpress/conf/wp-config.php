<?php

function get_docker_secret($secret_name) {
    $secret_path = '/run/secrets/' . $secret_name;
    if (file_exists($secret_path)) {
        return trim(file_get_contents($secret_path));
    }
    return false;
}

define( 'DB_NAME', getenv('DB_NAME') );
define( 'DB_USER', getenv('DB_USER') );
define( 'DB_PASSWORD', get_docker_secret('db_password') );
define( 'WP_HOME', getenv('WP_FULL_URL') );
define( 'WP_SITEURL', getenv('WP_FULL_URL') );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
define( 'AUTH_KEY',         '' );
define( 'SECURE_AUTH_KEY',  '' );
define( 'LOGGED_IN_KEY',    '' );
define( 'NONCE_KEY',        '' );
define( 'AUTH_SALT',        '' );
define( 'SECURE_AUTH_SALT', '' );
define( 'LOGGED_IN_SALT',   '' );
define( 'NONCE_SALT',       '' );

define('FORCE_SSL_ADMIN', true);
if (strpos($_SERVER['HTTP_X_FORWARDED_PROTO'], 'https') !== false)
    $_SERVER['HTTPS']='on';

$table_prefix = 'wp_';

define( 'WP_DEBUG', true );

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';