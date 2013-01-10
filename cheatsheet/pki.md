# openssl

    # Add passphrase to private key
    openssl rsa -aes256 -in amazon.key -out amazon.locked.key \
        -passout pass:PASSPHRASE        # Supply passphrase on commandline
        -passout file:PASSPHRASE_FILE   # Supply passphrase in file

    # Remove passphrase from private key
    openssl rsa -in key.locked.pem -out key.unlocked.pem

    # Extract public and private key from cert
    openssl rsa  -in mycert.pem -out newcert.pem
    openssl x509 -in mycert.pem   >> newcert.pem

    # Convert pubkey.pub to ssh-rsa format
    ssh-keygen -f pubkey.pub -i -m PKCS8 > pubkey.ssh.pub
