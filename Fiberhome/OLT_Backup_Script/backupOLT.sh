######################################################################
##       ###  #####################  #################################
##  #####  #  #####################  #################################
##  ########  #####################  #################################
##      ####     ####     ##  ##  #      ####    ####   #  ###     ###
##  #####  #  ##  ##  ###  #  #  ##  ###  ##  ##  ##  #  #  #  ###  ##
##  #####  #  ###  #      ##   ####  ###  #  ####  #  #  #  #      ###
##  #####  #  ##  ##  ######  #####  ###  ##  ##  ##  #  #  #  #######
##  #####  #     ####      #  #####  ###  ###    ###  #  #  ##      ##
######################################################################
#!/bin/bash

#Made by Gustavo Iago Felippe | gustavoifelippe@hotmail.com

##Declaracao de variavel
log=/Backup/ftp_olt/Fiberhome/OLT_Backup_Script/log
hostAddr="";
hostName="";
loginUser="";
loginPasswd="";
enablePasswd="";
ftpDirectory="Fiberhome/OLT_Backup_Files/";
ftpUser="ftpUser";
ftpPasswd="ftpPasswd";
ftpServer="0.0.0.0";
date=`date +%d-%m-%Y`;


##Function Declarations
geraBK(){

        expect -c "

        ##Invocando Telnet
        spawn telnet $hostAddr;

        ##Logando com usuario e senha
        expect \"Login:\";
        send \"$loginUser\r\";
        expect \"Password:\";
        send \"$loginPasswd\r\";

        ##Habilitando modo de configuracao
        expect \"User>\";
        send \"en\r\";
        expect \"Password:\";
        send \"$enablePasswd\r\";

        ##Enviando Backup para FTP
        expect -re .*#;
        send \"upload ftp config $ftpServer $ftpUser $ftpPasswd $ftpDirectory/$date-$hostName\r\";
        expect -re .*#;
        send \"quit\r\";" >> $log 2>&1

}


###Starting Backup###
while read line;
do
        hostAddr=`echo $line | cut -d'|' -f1`;
        loginUser=`echo $line | cut -d'|' -f2`;
        loginPasswd=`echo $line | cut -d'|' -f3`;
        enablePasswd=`echo $line | cut -d'|' -f4`;
        hostName=`echo $line | cut -d'|' -f5`;
        echo "!!!!!!!!!!!!! Starting Backup of OLT $hostName IP: "$hostAddr" !!!!!!!!!!!!" >> $log;
        geraBK;
        echo "" >> $log;
done < /Backup/ftp_olt/Fiberhome/OLT_Backup_Script/devicesOLT

##Ending Backup
echo "!!!!!!!!!!!!! Ending Backup of OLT $hostName !!!!!!!!!!!!" >> $log;

