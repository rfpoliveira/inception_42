<?php
function get_docker_secret($secret_name) {
    $secret_path = '/run/secrets/' . $secret_name;
    if (file_exists($secret_path)) {
        return trim(file_get_contents($secret_path));
    }
    return false;
}

define( 'DB_NAME',     getenv('DB_NAME') );
define( 'DB_USER',     getenv('DB_USER') );
define( 'DB_PASSWORD', get_docker_secret('db_password') );
define( 'DB_HOST',     getenv('DB_HOST') );
define( 'DB_CHARSET',  'utf8mb4' );
define( 'DB_COLLATE',  '' );

define( 'WP_HOME',    getenv('WP_FULL_URL') );
define( 'WP_SITEURL', getenv('WP_FULL_URL') );

define( 'AUTH_KEY',         getenv('WP_AUTH_KEY') );
define( 'SECURE_AUTH_KEY',  getenv('WP_SECURE_AUTH_KEY') );
define( 'LOGGED_IN_KEY',    getenv('WP_LOGGED_IN_KEY') );
define( 'NONCE_KEY',        getenv('WP_NONCE_KEY') );
define( 'AUTH_SALT',        getenv('WP_AUTH_SALT') );
define( 'SECURE_AUTH_SALT', getenv('WP_SECURE_AUTH_SALT') );
define( 'LOGGED_IN_SALT',   getenv('WP_LOGGED_IN_SALT') );
define( 'NONCE_SALT',       getenv('WP_NONCE_SALT') );

define( 'FORCE_SSL_ADMIN', true );
if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) &&
    strpos($_SERVER['HTTP_X_FORWARDED_PROTO'], 'https') !== false) {
    $_SERVER['HTTPS'] = 'on';
}

$table_prefix = 'wp_';

define( 'WP_DEBUG', false );

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}
require_once ABSPATH . 'wp-settings.php';