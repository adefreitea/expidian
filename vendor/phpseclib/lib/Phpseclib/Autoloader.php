<?php

/*
 * This file is part of PhpSecLib.
 *
 * 
 */

/**
 * Autoloads Phpseclib classes.
 *
 * @package Phpseclib
 * @author  José Gabriel González
 */
class Phpseclib_Autoloader
{
    /**
     * Registers Phpseclib_Autoloader as an SPL autoloader.
     */
    static public function register()
    {
        ini_set('unserialize_callback_func', 'spl_autoload_call');
        spl_autoload_register(array(new self, 'autoload'));
    }

    /**
     * Handles autoloading of classes.
     *
     * @param  string  $class  A class name.
     *
     * @return boolean Returns true if the class has been loaded
     */
    static public function autoload($class)
    {
        if (0 !== strpos($class, 'Phpseclib')) {
            return;
        }

        if (file_exists($file = dirname(__FILE__).'/../'.str_replace(array('_', "\0"), array('/', ''), $class).'.php')) {
            require $file;
        }
    }
}
