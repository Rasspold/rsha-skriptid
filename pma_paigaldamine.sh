# phpmyadmini paigaldamine skripti abil
#
# Kontrollitakse ega teil antud rakendust juba olemas ei ole
#
PMA=$(dpkg-query -W -f='${status}' phpmyadmin 2>/dev/null | grep -c 'ok installitud')
# Kui väärtus on 0, siis teostatakse install
if [ $PMA -eq 0 ]; then
	echo "pma ning vajalike lisade paigaldamine"
	apt install phpmyadmin
	echo "phpmyadmin on paigaldatud"
# Kui väärtus on 1, siis pakette uuesti ei installeerita
elif [ $PMA -eq 0 ]; then
	echo "phpmyadmin on juba paigaldatud"
fi
# Skripti lõpp
