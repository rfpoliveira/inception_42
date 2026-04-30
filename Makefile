#==============================================================================#
#                                 Files and Paths                              #
#==============================================================================#

NAME		= inception

SRCS		= ./srcs

COMPOSE		= $(SRCS)/docker-compose.yml

HOST_URL	= rpedrosa.42.fr


#==============================================================================#
#                                    Rules                                     #
#==============================================================================#

all: up

up:
	@mkdir -p /home/$(USER)/data/mariadb
	@mkdir -p /home/$(USER)/data/wordpress
	@mkdir -p ./secrets
	@if ! grep -q "$(HOST_URL)" /etc/hosts; then \
		echo "127.0.0.1 $(HOST_URL)" | sudo tee -a /etc/hosts; \
	fi
	docker compose -f $(COMPOSE) up --build -d

down:
	docker compose -f $(COMPOSE) down

clean:
	docker compose -f $(COMPOSE) down --volumes --rmi all

fclean: clean
	@sudo rm -rf /home/$(USER)/data
	@docker system prune -a --force

re: fclean all

#==============================================================================#
#                                  UTILS                                       #
#==============================================================================#

# Colors
#
# Run the following command to get list of available colors
# bash -c 'for c in {0..255}; do tput setaf $c; tput setaf $c | cat -v; echo =$c; done'
#
B  		= $(shell tput bold)
BLA		= $(shell tput setaf 0)
RED		= $(shell tput setaf 1)
GRN		= $(shell tput setaf 2)
YEL		= $(shell tput setaf 3)
BLU		= $(shell tput setaf 4)
MAG		= $(shell tput setaf 5)
CYA		= $(shell tput setaf 6)
WHI		= $(shell tput setaf 7)
GRE		= $(shell tput setaf 8)
BRED 	= $(shell tput setaf 9)
BGRN	= $(shell tput setaf 10)
BYEL	= $(shell tput setaf 11)
BBLU	= $(shell tput setaf 12)
BMAG	= $(shell tput setaf 13)
BCYA	= $(shell tput setaf 14)
BWHI	= $(shell tput setaf 15)
D 		= $(shell tput sgr0)
BEL 	= $(shell tput bel)
CLR 	= $(shell tput el 1)
