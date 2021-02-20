# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lorenuar <lorenuar@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/04/10 13:37:24 by lorenuar          #+#    #+#              #
#    Updated: 2021/02/20 18:49:18 by lorenuar         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# ================================ VARIABLES ================================= #

NAME	= Program

CC	= gcc
CFLAGS	= -Wall -Werror -Wextra

ifeq ($(DEBUG),1)
CFLAGS	+= -g3 -fsanitize=address
endif

SRCDIR	= src/
INCDIR	= includes/
OBJDIR	= bin/

CFLAGS	+= -I $(INCDIR)

LDFLAGS =

###▼▼▼<src-updater-do-not-edit-or-remove>▼▼▼
# **************************************************************************** #
# **   Generated with https://github.com/lorenuars19/makefile-src-updater   ** #
# **************************************************************************** #

SRCS =\

HEADERS = \

###▲▲▲<src-updater-do-not-edit-or-remove>▲▲▲

SRC		:= $(notdir $(SRCS)) # 				Files only
OBJ		:= $(SRC:.c=.o)	#				Files only
OBJS	:= $(addprefix $(OBJDIR), $(OBJ)) #		Full path

GR	= \033[32;1m#	Green
RE	= \033[31;1m#	Red
YE	= \033[33;1m#	Yellow
CY	= \033[36;1m#	Cyan
RC	= \033[0m #	Reset Colors

VPATH = $(SRCDIR):$(OBJDIR)

# ================================== RULES =================================== #

all : $(NAME)

$(OBJDIR)%.o : %.c
	@mkdir -p $(OBJDIR)
	@printf "$(GR)+$(RC)"
	@$(CC) $(CFLAGS) -c $< -o $@

#	Linking
$(NAME)	: $(SRCS) $(HEADERS) $(OBJS)
	@printf "\n$(GR)=== Compiled [$(CC) $(CFLAGS)] ===\n--- $(SRC)$(RC)\n"
	@$(CC) $(LDFLAGS) $(CFLAGS) -o $(NAME) $(OBJS)
	@printf "$(YE)&&& Linked [$(CC) $(LDFLAGS)] &&&\n--- $(NAME)$(RC)\n"

#	cleaning
clean :
	@echo "$(RE)--- Removing $(OBJDIR)$(RC)"
	@rm -rf $(OBJDIR)

fclean : clean
	@echo "$(RE)--- Removing $(NAME)$(RC)"
	@rm -f $(NAME)

re : fclean all

run : $(NAME)
	@echo "$(CY)>>> Running $(NAME)$(RC)"
	./$(NAME)

debug :
	@echo "SRCS $(SRCS)"
	@echo "SRC $(SRC)"
	@echo "OBJS $(OBJS)"
	@echo "OBJ $(OBJ)"
	@echo "CSRCS $(CSRCS)"
	@echo "CFLAGS $(CFLAGS)"

.PHONY	= all run clean fclean re debug
