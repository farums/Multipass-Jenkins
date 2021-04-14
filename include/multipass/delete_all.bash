#!/usr/bin/env bash
################################################################################
# 👉                              load                                    👈 #
################################################################################
SELF_FILE=$0
SELF=`dirname ${SELF_FILE}`
source "$SELF/../function.sh"
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
# 👉                        multipass    stop                              👈 #
################################################################################
stopMLPStack() {
  if ! multipass stop --all
  then
    exitOnErr "multipass stop --all failed"
  fi
}
################################################################################
# 👉                      multipass    delete                              👈 #
################################################################################
deleteMLPStack() {
  if ! multipass delete --all
  then
    exitOnErr "multipass delete --all failed"
  fi
}
################################################################################
# 👉                            init                                       👈 #
################################################################################
function_Color
stopMLPStack
deleteMLPStack
multipass.exe purge
echo -e "${GREEN}Done${NC}"