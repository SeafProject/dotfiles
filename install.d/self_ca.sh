tmp=/tmp/tmp-$$

CA_DIR=/opt/pki/AvapCA

[ -d $CA_DIR ] || sudo mkdir -vp /opt/pki/AvapCA

cat /etc/ssl/openssl.cnf |\
sed -e "/^dir/s|dir.*|dir = $CA_DIR|" |\
cat - > $tmp-cnf

cat $tmp-cnf | sudo tee /opt/pki/AvapCA/openssl.cnf > /dev/null

[ -d $CA_DIR/certs ]    || sudo mkdir -p $CA_DIR/certs
[ -d $CA_DIR/private ]  || (sudo mkdir -p $CA_DIR/private && sudo chmod 700 $CA_DIR/private)
[ -d $CA_DIR/crl ]      || sudo mkdir -p $CA_DIR/crl
[ -d $CA_DIR/newcerts ] || sudo mkdir -p $CA_DIR/newcerts

[ -f $CA_DIR/serial ] || {
	echo "01" | sudo tee $CA_DIR/serial
}

[ -f $CA_DIR/index.txt ] || sudo touch $CA_DIR/index.txt



cd $CA_DIR

# CA Keyの作成
OPENSSL_REQ="sudo openssl req"
OPENSSL_REQ="$OPENSSL_REQ -config $CA_DIR/openssl.cnf"

OPENSSL_SIGN="sudo openssl ca"
OPENSSL_SIGN="$OPENSSL_SIGN -config $CA_DIR/openssl.cnf"

OPENSSL_RSA="sudo openssl rsa"
#OPENSSL_RSA="$OPENSSL_RSA -config $CA_DIR/openssl.cnf"

[ -f cacert.pem ] || $OPENSSL_REQ -new -x509 -newkey rsa:2048 -days 1825 -out cacert.pem -keyout private/cakey.pem

# DER Fileの作成
OPENSSL_X509="sudo openssl x509"

[ -f avap_ca.der ] || $OPENSSL_X509 -inform PEM -outform DER -in $CA_DIR/cacert.pem -out avap_ca.der

sudo cp avap_ca.der /var/www/html/avap_ca.der

# Server用の証明書を作成
HOST=public.avap.co.jp
HOST_DIR=$CA_DIR/$HOST

[ -d $HOST_DIR ] || mkdir $HOST_DIR

$OPENSSL_X509 -in $HOST_DIR/cert.pem > /dev/null
if [ $? -ne 0 ]
then
	if [ ! -f $HOST_DIR/key.pem ]
	then
		$OPENSSL_REQ -new -keyout $HOST_DIR/key.pem -out  $HOST_DIR/csr.pem
		$OPENSSL_SIGN -out $HOST_DIR/cert.pem -infiles $HOST_DIR/csr.pem
		$OPENSSL_RSA -in $HOST_DIR/key.pem -out $HOST_DIR/key.pem.nopass
	fi
fi

find $CA_DIR

rm $tmp-*
