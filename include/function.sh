################################################################################
# 👉                             replace_text                              👈 #
################################################################################
function file_replace_text {

  local -r original_text_regex="$1"
  local -r replacement_text="$2"
  local -r file="$3"

  local args=()
  args+=("-i")

  args+=("s|$original_text_regex|$replacement_text|")
  args+=("$file")
  sed "${args[@]}" > /dev/null
}
################################################################################
# 👉                            Color                                      👈 #
################################################################################
function function_Color {
    export NC='\033[0m'
    export RED='\033[0;31m'
    export GREEN='\033[0;32m'
    export YELLOW='\033[0;33m'
    export BLUE='\033[1;34m'
}
################################################################################
# 👉                            multipass                                  👈 #
################################################################################
function multipass(){
## Nothing to change after this line
if [ -x "$(command -v multipass.exe)" > /dev/null 2>&1 ]; then
  # Windows
  MULTIPASSCMD="multipass.exe"
elif [ -x "$(command -v multipass)" > /dev/null 2>&1 ]; then
  # Linux/MacOS
  MULTIPASSCMD="multipass"
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    SET="sed -i \"\""
  fi
else
   echo -e "${RED} Error: ${GREEN} (multipass or multipass.exe)  not found. Please install by yourself ${NC}"
   echo -e "PATH ${GREEN}\$PATH${NC}"
   exit 1
fi
  ${MULTIPASSCMD} "$@"
}
################################################################################
# 👉                      eturns the IP or                                 👈 #
################################################################################
function get_local_ip(){
    case "$OSTYPE" in
        darwin*) IP=$(ifconfig en0 | grep inet | grep -v inet6 | cut -d" " -f2)
                 echo "$IP"
                 return 0
                 ;;
        linux*)  IP=$(hostname -I |  cut -d" " -f1)
                 echo "$IP"
                 return 0
                 ;;
        cygwin* | mingw* | msys*)
                IP=$(netstat -rn | grep -w '0.0.0.0' | awk '{ print $4 }')
                 echo "$IP"
                 return 0
                 ;;
        *) echo "unknown: $OSTYPE"
                 return 1
                 ;;
    esac
}
################################################################################
# 👉                      display_time                                     👈 #
################################################################################
function display_time {
    local T=$1
    local D=$((T/60/60/24))
    local H=$((T/60/60%24))
    local M=$((T/60%60))
    local S=$((T%60))
    (( D > 0 )) && printf '%d days ' $D
    (( H > 0 )) && printf '%d hours ' $H
    (( M > 0 )) && printf '%d minutes ' $M
    (( D > 0 || H > 0 || M > 0 )) && printf 'and '
    printf '%d seconds\n' $S
}
################################################################################
# 👉                      create_directory                                 👈 #
################################################################################
function create_directory_if_not_exists(){
    DIR_NAME=$1
    ## Create Directory If Not Exists
    if [ ! -d "$DIR_NAME"  ]; then
      mkdir -p "$DIR_NAME"
    fi
}
################################################################################
# 👉                            Error                                      👈 #
################################################################################
exitOnErr() {
  local date=$(date)
  echo -e "${RED} Error:${GREEN} <$(date)>${RED}$1${NC}, exiting ..."
  exit 1
}
################################################################################
# 👉                            init                                       👈 #
################################################################################
function_Color
echo -e "${BLUE}Запуск ${GREEN} function.sh ${NC}"