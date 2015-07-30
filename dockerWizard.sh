#!/bin/bash
# Info acerca de docker https://github.com/Edux87/DockerEsp

message ()
{
    printf "####> $1\n"
}

showopts () {
  while getopts ":pq:" optname
    do
      case "$optname" in
        "p")
          echo "Option $optname is specified"
          ;;
        "q")
          echo "Option $optname has value $OPTARG"
          ;;
        "?")
          echo "Unknown option $OPTARG"
          ;;
        ":")
          echo "No argument value for option $OPTARG"
          ;;
        *)
        # Should not occur
          echo "Unknown error while processing options"
          ;;
      esac
    done
  return $OPTIND
}

showargs () {
  for p in "$@"
    do
      echo "[$p]"
    done
}

optinfo=$(showopts "$@")
argstart=$?
arginfo=$(showargs "${@:$argstart}")
echo "Arguments are:"
echo "$arginfo"
echo "Options are:"
echo "$optinfo"



