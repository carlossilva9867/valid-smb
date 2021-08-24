#!/bin/bash
#Autor Carlos Silva 29/03/2021
echo "#------------------------------------------------------------------------#"
echo -e "#\e[1;33m               SCRIPT PARA LISTAR SESSÕES ATIVAS NO SAMBA               \e[0m#"
echo -e "#\e[1;36m                                              CRIADO em: 29/03/2021     \e[0m#"
echo -e "#\e[1;36m                                              VERSÃO: 1.0               \e[0m#"
echo "#------------------------------------------------------------------------#"

PS3='Por favor escolha uma opção: '
options=("LISTAR SESSÕES ATIVAS 1" "VERIFICAR SE O SERVIÇO ESTA RODANDO 2" "REINICIAR O SAMBA 3" "FINALIZAR UMA SESSAO 4" "Sair 5")
select opt in "${options[@]}"

do
    case $opt in
        "LISTAR SESSÕES ATIVAS 1")
             #echo -e "#\e[1;31m `sudo /usr/bin/smbstatus` \e[1m#"
             sudo /usr/bin/smbstatus
            ;;
        "VERIFICAR SE O SERVIÇO ESTA RODANDO 2")
            /usr/sbin/service smb status
            ;;

        "REINICIAR O SAMBA 3" )
            sudo /usr/sbin/service smb restart
            ;;
        "FINALIZAR UMA SESSAO 4" )
            Procs=$(ps -aux | grep -ie smbd | awk '{print $2}')
            echo "Por favor,digite o PID do processo "
            read SMBPID
            if [ $(echo $Procs | grep -c ${SMBPID}) -eq 1 ] #kill somente no processo do samba
            then
                sudo /usr/bin/kill $SMBPID
                echo -e "\e[1;32mProcesso $SMBPID, finalizado com sucesso. \e[0m"
            else
                echo -e "\e[1;31mPID inválido, favor inserir somente o PID do samba. \e[0m"
                fi
            ;;
        "Sair 5")
            break
            ;;
        *) echo -e "\e[1;33m OPÇÃO INCORRETA $REPLY\e[0m"
        ;;

    esac
done
