#!/bin/bash
#Info acerca de docker https://github.com/Edux87/DockerEsp
#DOCKER INSTALLER 1.0

message ()
{
    printf "####> $1\n"
}

if [ $SUDO_USER ]; then user=$SUDO_USER; else user=`whoami`; fi

message "Hola $user, Vamos a instalar docker :D ...."
message "Es probable que tengas que ingresar tu pass de superusuario algunas veces!"
message "1. Verificando dependencias"

if [ ! -x /usr/bin/wget  ];then
    message "No tienes instalado el paquete WGET, lo instalare x ti."
    sudo apt-get install wget
else
    message "1. [i] Tenemos wget"
fi

message "2. Vamos al Home"
cd ~
sudo usermod -aG docker $user

if [ ! -x /usr/bin/docker ];then
    message "3. Instalando Docker."
    wget -qO- https://get.docker.com/ | sh
    message " ---> Asignando Permisos para Docker"
    sudo usermod -aG docker $user
    message " AVISO IMPORANTE!! ##########################################################################"
    message " ############################################################################################"
    message " Para efecto del usermod es necesario Cerrar la Session y luego VOLVER A EJECUTAR este script"
    message " ############################################################################################"
    exit
else
    message "3. [i] Ya tienes Docker insalado"
fi

if [ ! -x /usr/local/bin/docker-compose ];then
    message "4. Instalando Docker Compose."
    curl -L https://github.com/docker/compose/releases/download/1.3.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
    message "5. Ambito global para DoCo"
    chmod +x /usr/local/bin/docker-compose
else
    message "5. [i] Ya tienes Docker Compose instalado"
fi

message "6. Creando Alias para dockerWizard!"

if [ ! -f /bin/bash/dockerWizard ]; then
    sudo cp ~/dockerWizard/dockerWizard.sh  /usr/local/bin/dockerWizard
    sudo +x /usr/local/bin/dockerWizard
    ln -s ~/dockerWizard/dockerWizard.sh /usr/local/bin/dockerWizard    
fi




