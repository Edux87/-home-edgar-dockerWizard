#!/bin/bash
# Info acerca de docker https://github.com/Edux87/DockerEsp

message ()
{
    printf "####> $1\n"
}

if [ $SUDO_USER ]; then user=$SUDO_USER; else user=`whoami`; fi

dirProyect=$1
dirForce=$2

    if [ ! -d "$dirProyect" ]; then
	message "Oops!, El directorio $dirProyect no existe"
	
	if [ "$dirForce" = "-f" ]; then
	    message "Creando Directorio $dirProyect"
	    mkdir -p $dirProyect
	else
	    message "Intenta crear tu carpeta de proyecto dentro de Home"
	    exit
	fi
    fi

message "Hola $user, Vamos a instalar docker :D ...."
message "Es probable que tengas que ingresar tu pass de superusuario algunas veces!"
message "1. Verificando dependencias"

if [ ! -x /usr/bin/wget  ];then
    message "No tienes instalado el paquete WGET, lo instalare x ti."
    sudo apt-get install wget
else
    message " ---> Tenemos wget"
fi

message "2. Vamos al Home"
cd ~
    sudo usermod -aG docker $user

if [ ! -x /usr/bin/docker ];then
    message "Instalando Docker."
    wget -qO- https://get.docker.com/ | sh
    message " ---> Asignando Permisos para Docker"
    sudo usermod -aG docker $user
    message " AVISO IMPORANTE!! ##########################################################################"
    message " ############################################################################################"
    message " Para efecto del usermod es necesario Cerrar la Session y luego VOLVER A EJECUTAR este script"
    message " ############################################################################################"
    exit
else
    message " ---> Ya tienes Docker insalado"
fi

if [ ! -x /usr/local/bin/docker-compose ];then
    message "Instalando Docker Compose."
    curl -L https://github.com/docker/compose/releases/download/1.3.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
    message "Ambito global para DoCo"
    chmod +x /usr/local/bin/docker-compose
else
    message " ---> Ya tienes Docker Compose instalado"
fi

dokiLamp="$(docker images | grep 'dockie/lamp' | sed -e 's/^[ \t]*//')"

if [ -n "$dokiLamp" ];then
    message "3. Tienes la imagen correcta"
else
    message "3. Clonando Imagenes Necesarias | Si, va a demorar y mucho ..."
    docker pull dockie/lamp
fi

message "4. Listando Imagenes | Done!"
docker images

message "5. Copiando Fuentes a tu carpeta de proyecto: $dirProyect"

cp docker-compose.yml Dockerfile $dirProyect

message "6. Done!"




