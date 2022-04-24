
echo -e "Welcome ${RED}`whoami` ${CYAN}Ansible${NC} 27.04.2021"
echo "`git --version`"
echo -e "${CYAN}MyBash${NC} version 1.1.0"
echo -e ${CYAN}PATH${NC} = `echo $PATH`
type -a code &> /dev/null && echo  -e "${CYAN}VS code server${NC} `code -v | head -n 1`"
echo -e "${CYAN}Ansible${NC} = `ansible --version | head -n 1`"