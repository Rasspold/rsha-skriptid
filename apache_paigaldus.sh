# apache paigaldamine
#
# kontrollitakse, kas apache on installitud kui mitte siis installitakse
#
APACHE2=$(dpkg-query -W -f='$(status)' apache2 2>/dev/null | grep -c 'ok installitud')
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
# Skripti lõpp
