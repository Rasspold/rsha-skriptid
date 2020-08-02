# mysql-serveri paigaldamine
#
#
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
# Skripti lõpp
