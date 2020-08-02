# php paigaldamine
#
# Kõigepealt kontrollitakse, kas soovitud paketid on äkki juba installitud
#
PHP=$(dpkg-query -W -f='${status}' php7.0 2>/dev/null | grep -c 'ok installitud')
# Kui järgmine väärtus on 0, siis paigaldatakse pakett
if [ $PHP -eq 0 ]; then
	echo "paigaldame php ja muud vajalikud paketid"
	apt install php7.0 libapache2-mod-php7.0 php7.0-mysql
	echo "php on paigaldatud"
# Kui väärtus on 1, siis installeerimist dopelt ei tehta
elif [ $PHP -eq 1 ]; then
	echo "PHP on juba paigaldatud"
	which php
fi
# skripti lõpp
