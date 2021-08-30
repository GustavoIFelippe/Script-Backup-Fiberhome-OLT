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

##Declaracao de variavel
log=/Backup/ftp_olt/Fiberhome/OLT_Backup_Script/log
hostAddr="";
hostName="";
loginUser="";
loginPasswd="";
enablePasswd="";
ftpDirectory="Fiberhome/OLT_Backup_Files/";
ftpUser="ftpolt";
ftpPasswd="fTp10oLt";
ftpServer="172.16.8.83";
date=`date +%d-%m-%Y`;


##Declaracao de funcao
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


###Iniciando o Backup###
while read line;
do
        hostAddr=`echo $line | cut -d'|' -f1`;
        loginUser=`echo $line | cut -d'|' -f2`;
        loginPasswd=`echo $line | cut -d'|' -f3`;
        enablePasswd=`echo $line | cut -d'|' -f4`;
        hostName=`echo $line | cut -d'|' -f5`;
        echo "!!!!!!!!!!!!! Iniciando Backup da OLT $hostName IP: "$hostAddr" !!!!!!!!!!!!" >> $log;
        geraBK;
        echo "" >> $log;
done < /Backup/ftp_olt/Fiberhome/OLT_Backup_Script/devicesOLT

##Finalizando Backup
echo "!!!!!!!!!!!!! Finalizando Backup da OLT $hostName !!!!!!!!!!!!" >> $log;

