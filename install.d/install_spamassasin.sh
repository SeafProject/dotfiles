tmp=/tmp/tmp-$$

sudo apt-get install spamassassin-rules-ja spampd spamassassin

SHOME="/var/log/spamassassin"
OPTIONS="--create-prefs"
OPTIONS="$OPTIONS --max-children 2"
OPTIONS="$OPTIONS --username spamd"
OPTIONS="$OPTIONS -H ${SHOME}/"
OPTIONS="$OPTIONS -s ${SHOME}/spamd.log"

OPTIONS=$(echo $OPTIONS| sed -e 's|/|\\/|g'  | tr -d "'")

cat /etc/default/spamassassin |\
	sed -e '/^ENABLED=0/s/0/1/' \
	-e '/^CRON=0/s/0/1/' \
	-e "/^OPTIONS/s/OPTIONS=.*/OPTIONS=\"${OPTIONS}\"/" > $tmp-def

cat $tmp-def | sudo tee /etc/default/spamassassin

id spamd
if [ $? -ne 0 ]
then
	sudo groupadd spamd
	sudo useradd -g spamd -s /bin/false -d $SHOME spamd
fi

sudo /etc/init.d/spamassassin restart

