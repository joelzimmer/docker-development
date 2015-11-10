<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// Food Coop-specific configuration

/** The location of the Food Coop API */
define('API_URL', 'http://WordPress:coop@localhost:3456/');

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'web');

/** MySQL database username */
define('DB_USER', 'web');

/** MySQL database password */
define('DB_PASSWORD', 'web');

/** MySQL hostname */
define('DB_HOST', 'localhost');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8mb4');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '3^6jx~5A,+(Z|en96pwVuU%nFBs!l3AGtnsc1tGxmTu{IT81(X_=X~|K_v>sQxb4');
define('SECURE_AUTH_KEY',  '+.-*XnQw`xaBh2jumH=EMJ8%UWs.bmu}2#-iw-|AW]BGM!gF4%hO@/u{&unR<AW.');
define('LOGGED_IN_KEY',    '7g*Cak+,j(25V]7Y/5fhqH9+95cE9<lw{T-fuR!EL/ -&Ha!%`Oy6J!W^?!=qwen');
define('NONCE_KEY',        '41>Q#N=w!GLXZf*mqR*<ejNo~aKAc4Nqi.jYn-r,<ih_`da^97+q!u6XOp*v?+b|');
define('AUTH_SALT',        'x2>Eb[KA|)+&:N>,setQ3J#lVm#$(L}x+*JNSs8z1^[HN>Pn2WwC<Bu`#%iJ5Kib');
define('SECURE_AUTH_SALT', ' %Xrk*D=-G@=OlBoMqRr!?OnnWcy5+Sew#$R4/hV)sdN/sLf<in: |=~/GJd!P$K');
define('LOGGED_IN_SALT',   'Om|SFKfp(u)GV<t<Fd]K#lZGI|c&:a,U|-*dbopW:0OHtYF=3)9Gm2R;:}3Bh#ik');
define('NONCE_SALT',       'F8e!{n[F*}o(DLp42X!uC%v97~lO3~UNqySjLKEe(_R-k=3&`($dM[n Sr~dD/=L');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define('WP_DEBUG', false);

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');

define( 'WP_SITEURL', 'http://foodcoopdev:6789/foodcoop-test' );
