<?php
/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * Pure-PHP implementation of Triple DES.
 *
 * Uses mcrypt, if available, and an internal implementation, otherwise.  Operates in the EDE3 mode (encrypt-decrypt-encrypt).
 *
 * PHP versions 4 and 5
 *
 * Here's a short example of how to use this library:
 * <code>
 * <?php
 *    include('Crypt/TripleDES.php');
 *
 *    $des = new Crypt_TripleDES();
 *
 *    $des->setKey('abcdefghijklmnopqrstuvwx');
 *
 *    $size = 10 * 1024;
 *    $plaintext = '';
 *    for ($i = 0; $i < $size; $i++) {
 *        $plaintext.= 'a';
 *    }
 *
 *    echo $des->decrypt($des->encrypt($plaintext));
 * ?>
 * </code>
 *
 * LICENSE: This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
 * MA  02111-1307  USA
 *
 * @category   Crypt
 * @package    Crypt_TripleDES
 * @author     Jim Wigginton <terrafrost@php.net>
 * @copyright  MMVII Jim Wigginton
 * @license    http://www.gnu.org/licenses/lgpl.txt
 * @version    $Id: TripleDES.php 81 2010-05-19 21:56:16Z admin $
 * @link       http://phpseclib.sourceforge.net
 */

/**
 * Include Crypt_DES
 */
require_once 'DES.php';

/**
 * Encrypt / decrypt using inner chaining
 *
 * Inner chaining is used by SSH-1 and is generally considered to be less secure then outer chaining (CRYPT_DES_MODE_CBC3).
 */
define('CRYPT_DES_MODE_3CBC', 3);

/**
 * Encrypt / decrypt using outer chaining
 *
 * Outer chaining is used by SSH-2 and when the mode is set to CRYPT_DES_MODE_CBC.
 */
define('CRYPT_DES_MODE_CBC3', CRYPT_DES_MODE_CBC);

/**
 * Pure-PHP implementation of Triple DES.
 *
 * @author  Jim Wigginton <terrafrost@php.net>
 * @version 0.1.0
 * @access  public
 * @package Crypt_TerraDES
 */
class Crypt_TripleDES {
    /**
     * The Three Keys
     *
     * @see Crypt_TripleDES::setKey()
     * @var String
     * @access private
     */
    var $key = "\0\0\0\0\0\0\0\0";

    /**
     * The Encryption Mode
     *
     * @see Crypt_TripleDES::Crypt_TripleDES()
     * @var Integer
     * @access private
     */
    var $mode = CRYPT_DES_MODE_CBC;

    /**
     * Continuous Buffer status
     *
     * @see Crypt_TripleDES::enableContinuousBuffer()
     * @var Boolean
     * @access private
     */
    var $continuousBuffer = false;

    /**
     * Padding status
     *
     * @see Crypt_TripleDES::enablePadding()
     * @var Boolean
     * @access private
     */
    var $padding = true;

    /**
     * The Initialization Vector
     *
     * @see Crypt_TripleDES::setIV()
     * @var String
     * @access private
     */
    var $iv = "\0\0\0\0\0\0\0\0";

    /**
     * A "sliding" Initialization Vector
     *
     * @see Crypt_TripleDES::enableContinuousBuffer()
     * @var String
     * @access private
     */
    var $encryptIV = "\0\0\0\0\0\0\0\0";

    /**
     * A "sliding" Initialization Vector
     *
     * @see Crypt_TripleDES::enableContinuousBuffer()
     * @var String
     * @access private
     */
    var $decryptIV = "\0\0\0\0\0\0\0\0";

    /**
     * MCrypt parameters
     *
     * @see Crypt_TripleDES::setMCrypt()
     * @var Array
     * @access private
     */
    var $mcrypt = array('', '');

    /**
     * The Crypt_DES objects
     *
     * @var Array
     * @access private
     */
    var $des;

    /**
     * Default Constructor.
     *
     * Determines whether or not the mcrypt extension should be used.  $mode should only, at present, be
     * CRYPT_DES_MODE_ECB or CRYPT_DES_MODE_CBC.  If not explictly set, CRYPT_DES_MODE_CBC will be used.
     *
     * @param optional Integer $mode
     * @return Crypt_TripleDES
     * @access public
     */
    function Crypt_TripleDES($mode = CRYPT_DES_MODE_CBC)
    {
        if ( !defined('CRYPT_DES_MODE') ) {
            switch (true) {
                case extension_loaded('mcrypt'):
                    // i'd check to see if des was supported, by doing in_array('des', mcrypt_list_algorithms('')),
                    // but since that can be changed after the object has been created, there doesn't seem to be
                    // a lot of point...
                    define('CRYPT_DES_MODE', CRYPT_DES_MODE_MCRYPT);
                    break;
                default:
                    define('CRYPT_DES_MODE', CRYPT_DES_MODE_INTERNAL);
            }
        }

        if ( $mode == CRYPT_DES_MODE_3CBC ) {
            $this->mode = CRYPT_DES_MODE_3CBC;
            $this->des = array(
                new Crypt_DES(CRYPT_DES_MODE_CBC),
                new Crypt_DES(CRYPT_DES_MODE_CBC),
                new Crypt_DES(CRYPT_DES_MODE_CBC)
            );

            // we're going to be doing the padding, ourselves, so disable it in the Crypt_DES objects
            $this->des[0]->disablePadding();
            $this->des[1]->disablePadding();
            $this->des[2]->disablePadding();

            return;
        }

        switch ( CRYPT_DES_MODE ) {
            case CRYPT_DES_MODE_MCRYPT:
                switch ($mode) {
                    case CRYPT_DES_MODE_ECB:
                        $this->mode = MCRYPT_MODE_ECB;    break;
                    case CRYPT_DES_MODE_CBC:
                    default:
                        $this->mode = MCRYPT_MODE_CBC;
                }

                break;
            default:
                $this->des = array(
                    new Crypt_DES(CRYPT_DES_MODE_ECB),
                    new Crypt_DES(CRYPT_DES_MODE_ECB),
                    new Crypt_DES(CRYPT_DES_MODE_ECB)
                );
 
                // we're going to be doing the padding, ourselves, so disable it in the Crypt_DES objects
                $this->des[0]->disablePadding();
                $this->des[1]->disablePadding();
                $this->des[2]->disablePadding();

                switch ($mode) {
                    case CRYPT_DES_MODE_ECB:
                    case CRYPT_DES_MODE_CBC:
                        $this->mode = $mode;
                        break;
                    default:
                        $this->mode = CRYPT_DES_MODE_CBC;
                }
        }
    }

    /**
     * Sets the key.
     *
     * Keys can be of any length.  Triple DES, itself, can use 128-bit (eg. strlen($key) == 16) or
     * 192-bit (eg. strlen($key) == 24) keys.  This function pads and truncates $key as appropriate.
     *
     * DES also requires that every eighth bit be a parity bit, however, we'll ignore that.
     *
     * If the key is not explicitly set, it'll be assumed to be all zero's.
     *
     * @access public
     * @param String $key
     */
    function setKey($key)
    {
        $length = strlen($key);
        if ($length > 8) {
            $key = str_pad($key, 24, chr(0));
            // if $key is between 64 and 128-bits, use the first 64-bits as the last, per this:
            // http://php.net/function.mcrypt-encrypt#47973
            $key = $length <= 16 ? substr_replace($key, substr($key, 0, 8), 16) : substr($key, 0, 24);
        }
        $this->key = $key;
        switch (true) {
            case CRYPT_DES_MODE == CRYPT_DES_MODE_INTERNAL:
            case $this->mode == CRYPT_DES_MODE_3CBC:
                $this->des[0]->setKey(substr($key,  0, 8));
                $this->des[1]->setKey(substr($key,  8, 8));
                $this->des[2]->setKey(substr($key, 16, 8));
        }
    }

    /**
     * Sets the initialization vector. (optional)
     *
     * SetIV is not required when CRYPT_DES_MODE_ECB is being used.  If not explictly set, it'll be assumed
     * to be all zero's.
     *
     * @access public
     * @param String $iv
     */
    function setIV($iv)
    {
        $this->encryptIV = $this->decryptIV = $this->iv = str_pad(substr($iv, 0, 8), 8, chr(0));
        if ($this->mode == CRYPT_DES_MODE_3CBC) {
            $this->des[0]->setIV($iv);
            $this->des[1]->setIV($iv);
            $this->des[2]->setIV($iv);
        }
    }

    /**
     * Sets MCrypt parameters. (optional)
     *
     * If MCrypt is being used, empty strings will be used, unless otherwise specified.
     *
     * @link http://php.net/function.mcrypt-module-open#function.mcrypt-module-open
     * @access public
     * @param optional Integer $algorithm_directory
     * @param optional Integer $mode_directory
     */
    function setMCrypt($algorithm_directory = '', $mode_directory = '')
    {
        $this->mcrypt = array($algorithm_directory, $mode_directory);
        if ( $this->mode == CRYPT_DES_MODE_3CBC ) {
            $this->des[0]->setMCrypt($algorithm_directory, $mode_directory);
            $this->des[1]->setMCrypt($algorithm_directory, $mode_directory);
            $this->des[2]->setMCrypt($algorithm_directory, $mode_directory);
        }
    }

    /**
     * Encrypts a message.
     *
     * @access public
     * @param String $plaintext
     */
    function encrypt($plaintext)
    {
        $plaintext = $this->_pad($plaintext);

        // if the key is smaller then 8, do what we'd normally do
        if ($this->mode == CRYPT_DES_MODE_3CBC && strlen($this->key) > 8) {
            $ciphertext = $this->des[2]->encrypt($this->des[1]->decrypt($this->des[0]->encrypt($plaintext)));

            return $ciphertext;
        }

        if ( CRYPT_DES_MODE == CRYPT_DES_MODE_MCRYPT ) {
            $td = mcrypt_module_open(MCRYPT_3DES, $this->mcrypt[0], $this->mode, $this->mcrypt[1]);
            mcrypt_generic_init($td, $this->key, $this->encryptIV);

            $ciphertext = mcrypt_generic($td, $plaintext);

            mcrypt_generic_deinit($td);
            mcrypt_module_close($td);

            if ($this->continuousBuffer) {
                $this->encryptIV = substr($ciphertext, -8);
            }

            return $ciphertext;
        }

        if (strlen($this->key) <= 8) {
            $this->des[0]->mode = $this->mode;

            return $this->des[0]->encrypt($plaintext);
        }

        // we pad with chr(0) since that's what mcrypt_generic does.  to quote from http://php.net/function.mcrypt-generic :
        // "The data is padded with "\0" to make sure the length of the data is n * blocksize."
        $plaintext = str_pad($plaintext, ceil(strlen($plaintext) / 8) * 8, chr(0));

        $ciphertext = '';
        switch ($this->mode) {
            case CRYPT_DES_MODE_ECB:
                for ($i = 0; $i < strlen($plaintext); $i+=8) {
                    $block = substr($plaintext, $i, 8);
                    $block = $this->des[0]->_processBlock($block, CRYPT_DES_ENCRYPT);
                    $block = $this->des[1]->_processBlock($block, CRYPT_DES_DECRYPT);
                    $block = $this->des[2]->_processBlock($block, CRYPT_DES_ENCRYPT);
                    $ciphertext.= $block;
                }
                break;
            case CRYPT_DES_MODE_CBC:
                $xor = $this->encryptIV;
                for ($i = 0; $i < strlen($plaintext); $i+=8) {
                    $block = substr($plaintext, $i, 8) ^ $xor;
                    $block = $this->des[0]->_processBlock($block, CRYPT_DES_ENCRYPT);
                    $block = $this->des[1]->_processBlock($block, CRYPT_DES_DECRYPT);
                    $block = $this->des[2]->_processBlock($block, CRYPT_DES_ENCRYPT);
                    $xor = $block;
                    $ciphertext.= $block;
                }
                if ($this->continuousBuffer) {
                    $this->encryptIV = $xor;
                }
        }

        return $ciphertext;
    }

    /**
     * Decrypts a message.
     *
     * @access public
     * @param String $ciphertext
     */
    function decrypt($ciphertext)
    {
        if ($this->mode == CRYPT_DES_MODE_3CBC && strlen($this->key) > 8) {
            $plaintext = $this->des[0]->decrypt($this->des[1]->encrypt($this->des[2]->decrypt($ciphertext)));

            return $this->_unpad($plaintext);
        }

        // we pad with chr(0) since that's what mcrypt_generic does.  to quote from http://php.net/function.mcrypt-generic :
        // "The data is padded with "\0" to make sure the length of the data is n * blocksize."
        $ciphertext = str_pad($ciphertext, (strlen($ciphertext) + 7) & 0xFFFFFFF8, chr(0));

        if ( CRYPT_DES_MODE == CRYPT_DES_MODE_MCRYPT ) {
            $td = mcrypt_module_open(MCRYPT_3DES, $this->mcrypt[0], $this->mode, $this->mcrypt[1]);
            mcrypt_generic_init($td, $this->key, $this->decryptIV);

            $plaintext = mdecrypt_generic($td, $ciphertext);

            mcrypt_generic_deinit($td);
            mcrypt_module_close($td);

            if ($this->continuousBuffer) {
                $this->decryptIV = substr($ciphertext, -8);
            }

            return $this->_unpad($plaintext);
        }

        if (strlen($this->key) <= 8) {
            $this->des[0]->mode = $this->mode;

            return $this->_unpad($this->des[0]->decrypt($plaintext));
        }

        $plaintext = '';
        switch ($this->mode) {
            case CRYPT_DES_MODE_ECB:
                for ($i = 0; $i < strlen($ciphertext); $i+=8) {
                    $block = substr($ciphertext, $i, 8);
                    $block = $this->des[2]->_processBlock($block, CRYPT_DES_DECRYPT);
                    $block = $this->des[1]->_processBlock($block, CRYPT_DES_ENCRYPT);
                    $block = $this->des[0]->_processBlock($block, CRYPT_DES_DECRYPT);
                    $plaintext.= $block;
                }
                break;
            case CRYPT_DES_MODE_CBC:
                $xor = $this->decryptIV;
                for ($i = 0; $i < strlen($ciphertext); $i+=8) {
                    $orig = $block = substr($ciphertext, $i, 8);
                    $block = $this->des[2]->_processBlock($block, CRYPT_DES_DECRYPT);
                    $block = $this->des[1]->_processBlock($block, CRYPT_DES_ENCRYPT);
                    $block = $this->des[0]->_processBlock($block, CRYPT_DES_DECRYPT);
                    $plaintext.= $block ^ $xor;
                    $xor = $orig;
                }
                if ($this->continuousBuffer) {
                    $this->decryptIV = $xor;
                }
        }

        return $this->_unpad($plaintext);
    }

    /**
     * Treat consecutive "packets" as if they are a continuous buffer.
     *
     * Say you have a 16-byte plaintext $plaintext.  Using the default behavior, the two following code snippets
     * will yield different outputs:
     *
     * <code>
     *    echo $des->encrypt(substr($plaintext, 0, 8));
     *    echo $des->encrypt(substr($plaintext, 8, 8));
     * </code>
     * <code>
     *    echo $des->encrypt($plaintext);
     * </code>
     *
     * The solution is to enable the continuous buffer.  Although this will resolve the above discrepancy, it creates
     * another, as demonstrated with the following:
     *
     * <code>
     *    $des->encrypt(substr($plaintext, 0, 8));
     *    echo $des->decrypt($des->encrypt(substr($plaintext, 8, 8)));
     * </code>
     * <code>
     *    echo $des->decrypt($des->encrypt(substr($plaintext, 8, 8)));
     * </code>
     *
     * With the continuous buffer disabled, these would yield the same output.  With it enabled, they yield different
     * outputs.  The reason is due to the fact that the initialization vector's change after every encryption /
     * decryption round when the continuous buffer is enabled.  When it's disabled, they remain constant.
     *
     * Put another way, when the continuous buffer is enabled, the state of the Crypt_DES() object changes after each
     * encryption / decryption round, whereas otherwise, it'd remain constant.  For this reason, it's recommended that
     * continuous buffers not be used.  They do offer better security and are, in fact, sometimes required (SSH uses them),
     * however, they are also less intuitive and more likely to cause you problems.
     *
     * @see Crypt_TripleDES::disableContinuousBuffer()
     * @access public
     */
    function enableContinuousBuffer()
    {
        $this->continuousBuffer = true;
        if ($this->mode == CRYPT_DES_MODE_3CBC) {
            $this->des[0]->enableContinuousBuffer();
            $this->des[1]->enableContinuousBuffer();
            $this->des[2]->enableContinuousBuffer();
        }
    }

    /**
     * Treat consecutive packets as if they are a discontinuous buffer.
     *
     * The default behavior.
     *
     * @see Crypt_TripleDES::enableContinuousBuffer()
     * @access public
     */
    function disableContinuousBuffer()
    {
        $this->continuousBuffer = false;
        $this->encryptIV = $this->iv;
        $this->decryptIV = $this->iv;

        if ($this->mode == CRYPT_DES_MODE_3CBC) {
            $this->des[0]->disableContinuousBuffer();
            $this->des[1]->disableContinuousBuffer();
            $this->des[2]->disableContinuousBuffer();
        }
    }

    /**
     * Pad "packets".
     *
     * DES works by encrypting eight bytes at a time.  If you ever need to encrypt or decrypt something that's not
     * a multiple of eight, it becomes necessary to pad the input so that it's length is a multiple of eight.
     *
     * Padding is enabled by default.  Sometimes, however, it is undesirable to pad strings.  Such is the case in SSH1,
     * where "packets" are padded with random bytes before being encrypted.  Unpad these packets and you risk stripping
     * away characters that shouldn't be stripped away. (SSH knows how many bytes are added because the length is
     * transmitted separately)
     *
     * @see Crypt_TripleDES::disablePadding()
     * @access public
     */
    function enablePadding()
    {
        $this->padding = true;
    }

    /**
     * Do not pad packets.
     *
     * @see Crypt_TripleDES::enablePadding()
     * @access public
     */
    function disablePadding()
    {
        $this->padding = false;
    }

    /**
     * Pads a string
     *
     * Pads a string using the RSA PKCS padding standards so that its length is a multiple of the blocksize (8).
     * 8 - (strlen($text) & 7) bytes are added, each of which is equal to chr(8 - (strlen($text) & 7)
     *
     * If padding is disabled and $text is not a multiple of the blocksize, the string will be padded regardless
     * and padding will, hence forth, be enabled.
     *
     * @see Crypt_TripleDES::_unpad()
     * @access private
     */
    function _pad($text)
    {
        $length = strlen($text);

        if (!$this->padding) {
            if (($length & 7) == 0) {
                return $text;
            } else {
                user_error("The plaintext's length ($length) is not a multiple of the block size (8)", E_USER_NOTICE);
                $this->padding = true;
            }
        }

        $pad = 8 - ($length & 7);
        return str_pad($text, $length + $pad, chr($pad));
    }

    /**
     * Unpads a string
     *
     * If padding is enabled and the reported padding length is invalid, padding will be, hence forth, disabled.
     *
     * @see Crypt_TripleDES::_pad()
     * @access private
     */
    function _unpad($text)
    {
        if (!$this->padding) {
            return $text;
        }

        $length = ord($text[strlen($text) - 1]);

        if (!$length || $length > 8) {
            user_error("The number of bytes reported as being padded ($length) is invalid (block size = 8)", E_USER_NOTICE);
            $this->padding = false;
            return $text;
        }

        return substr($text, 0, -$length);
    }
}

// vim: ts=4:sw=4:et:
// vim6: fdl=1: