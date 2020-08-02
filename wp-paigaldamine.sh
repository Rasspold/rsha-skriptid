# Kõigepealt paigaldatakse Apache
#
#
APACHE=$(dpkg-query -W -f='${Status}' apache2 2>/dev/null | grep -c 'ok installed')
# Kui järgnev väärtus on null, siis teostatakse install
if [ $APACHE2 -eq 0 ]; then
        echo "Paigaldame apache"
        apt install apache2
        echo "Apache on paigaldatud"
# Kui järgnev väärtus on 1, siis on apache juba installitud ning seda uuesti teha ei ole vaja
elif [ $APACHE2 -eq 1 ]; then
        echo "Apache on juba paigaldatud"
        service apache2 start
        service apache2 status
fi
#
#
# Järgmisena paigaldatakse php

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

#
#
# Järgnevalt paigaldatakse mysql- server
# Kõigepealt kontrollitakse, kas äkki sul on juba mysql server installeeritud
#
MYSQL=$(dpkg-query -W -f='${status}' mysql-server 2>/dev/null | grep -c 'ok installitud')
# Kui väärtus on 0, siis teostatakse install
if [ $MYSQL -eq 0 ]; then
        echo "Paigaldame mysql ja vajalikud lisad"
        apt install mysql-server
        echo "mysql on paigaldatud"
        # anname kasutajale võimaluse kasutada mysqli ilma paroolita
        touch $HOME/.my.cnf #konfi failid kasutaja kodukataloogi
        echo "[client]" >> $HOME/.my.cnf
        echo "host = localhost" >> $HOME/.my.cnf
        echo "user = root" >> $HOME/.my.cnf
        echo "password = qwerty" >> $HOME/.my.cnf
# Kui väärtus on 1, siis mysqli installi uuesti ei teostata
elif [ $MYSQL -eq 1 ]; then
        echo "mysql-server on juba installeeritud"
        mysql
fi

#
# Nüüd luuakse andmebaas
mysql <<EOF
CREATE DATABASE wordpress;
CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'qwerty';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'localhost';
FLUSH PRIVILEGES;
EOF

#
# wp allalaadimine ning failide pakkimine soovitud kohta
cd /var/www/html/
wget https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
cp wordpress/wp-config-sample.php wordpress/wp-config.php

#
# Viimase sammuna on vaja vaid wordpress konfigureerida

cd /var/www/html/wordpress/
sed -i 's/database_name_here/wordpress/g' wp-config.php
sed -i 's/username_here/wordpressuser/g' wp-config.php
sed -i 's/password_here/qwerty/g' wp-config.php

echo "Kõik vajalikud toimingud on teostatud ning olete valmis oma veebilehte üles ehitama!"

# skripti lõpp
