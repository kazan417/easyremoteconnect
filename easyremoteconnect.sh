#!/bin/bash
###автор Казанцев Михаил Валеьевич (kazan417@mail.ru) лицензия MIT
echo "ВНИМАНИЕ. По умолчению адрес сервкра server"
echo "Если нужно поменять имя сервера то изменяете в редакторе строчку /v:server  на /v:нужный_сервер в файле server.desktop"
echo "Это скрипт для настройки подключения к удаленному RDP серверу"
echo "Делает так, что при входе на компьютер нового пользователя ему на рабочий стол добавляется ярлык для подключения к серверу"
echo "Также перенаправляются принтера и смарткарты (должен быть установлен драйвер)"
if [ -n "$(command -v yum)" ]; then
  if [[ $EUID -ne 0 ]]; then
	 echo "найден yum устанавливаем требуемые программы с помощью yum"
     echo "введите пароль суперпользователя"
     su -c 	"/bin/bash ./easyremoteconnect.sh"
     if [ -f "/usr/share/icons/rdp.png" ]; then
       echo " удаленное подключение настроено"
       read
       exit 0
     else
       echo "Ошибка получения привелегированных прав доступа"
       read
     fi
     exit 1
  fi
     echo "найден yum устанавливаем требуемые программы с помощью yum"
     yum -y install xfreerdp -y

fi
if [ -n "$(command -v apt-get)" ]; then
	echo "найден apt-get устанавливаем требуемые программы с помощью apt-get"
  if [[ $EUID -ne 0 ]]; then
     echo "введите пароль пользователся с правами sudo"
     su -c 	"/bin/bash ./easyremoteconnect.sh"
     if [ -f "/usr/share/icons/rdp.png" ]; then
       echo "автоматическое монтирование настроено"
       read
       exit 0
     else
       echo "Ошибка получения привелегированных прав доступа"
       read
     fi
     exit 1
  fi
	apt-get -y install freerdp2-x11
fi
echo "копируем иконку rdp"
mv rdp.png /usr/share/icons/rdp.png
cp server.desktop /etc/skel
cp server.desktop /etc/skel/Desktop
cp server.desktop ~/Desktop
chmod a+r /etc/skel/server.desktop
chmod a+r /etc/skel/Desktop/server.desktop
echo "все выполнено успешно. Нажмите любую клавишу..."
read
