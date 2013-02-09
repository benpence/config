# symmetric

    # (En)(De)crypt a file
    openssl enc                     \
        -out <encrypted_file>       \
        -in <decrypted_file>        \
        -e -d                       \   # '-e' for encrypt, '-d' for decrypt
        -<cipher>                   \   # example aes-256-cbc ("man enc" for more)
        -salt

# asymmetric

    # Generate private key
    openssl <algorithm>             \   # genrsa | gendsa
        -out <key_file>             \
        -<cipher>                   \   # (optional) des | des3 | idea
        <bits>

    # Convert public key to ssh-rsa format
    ssh-keygen -f <public_key_file> -i -m PKCS8 > <ssh_public_key_file>

    # Add passphrase to private key
    openssl rsa
        -out <encrypted_key>        \
        -aes256                     \
        -in <key_file>              \
                                    \
        # Passphrase (choose one)   \
        -passout pass:<passphrase>  \   # command line
                 file:<file>        \   # file
                 env:<variable>     \   # environment variable
                 fd:<descriptor>    \   # file descriptor number
                 stdin

    # Remove passphrase from private key
    openssl rsa                     \
        -out <decrypted_key_file>   \
        -in <key_file>              \
                                    \
        # Passphrase (choose one)   \
        -passin pass:<passphrase>   \   # command line
                file:<file>         \   # file
                env:<variable>      \   # environment variable
                fd:<descriptor>     \   # file descriptor number
                stdin

    # Generate CSR (Certificate Signing Request)
    openssl req                     \
        -out <csr_file>             \
        -key <key_file>             \
        -new 

    # Sign certificate
    openssl x509                    \
        -out <cert_file>            \
        -in <csr_file>              \
        -signkey <key_file>         \
        -days <days>                \   # Validity
        -req 

    # Extract public and private key from cert
    openssl rsa  -in <cert_file> -out <private_key_file>
    openssl x509 -in <cert_file>   >> <public_key_file>

    # Certificate information
    openssl x509                    \
        -noout                      \
        -in <cert_file>             \
        -text

    # TODO: http://wiki.samat.org/CheatSheet/OpenSSL
    #       http://www.sslshopper.com/article-most-common-openssl-commands.html
    #       Read more about certificate formats
