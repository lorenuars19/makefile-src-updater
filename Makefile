# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lorenuar <lorenuar@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/04/10 13:37:24 by lorenuar          #+#    #+#              #
#    Updated: 2020/04/19 15:30:54 by lorenuar         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# ================================ VARIABLES ================================= #

NAME	= program

CC	= gcc
CFLAGS	= -Wall -Werror -Wextra

ifeq ($(DEBUG),1)
CFLAGS	+= -g3 -fsanitize=address
endif

SRCDIR	= src/
INCDIR	= include/
OBJDIR	= objs/

CFLAGS	+= -I $(INCDIR)

###▼▼▼<src-updater-do-not-edit-or-remove>▼▼▼
# **************************************************************************** #
# **   Generated with https://github.com/lorenuars19/makefile-src-updater   ** #
# **************************************************************************** #
SRCS = \
	./src/src.c \
	./src/sub/o.c \
	./src/sub/e.c \

HEADERS = \
	./inc/subHeader/TES.h \
	./inc/Text.h \

###▲▲▲<src-updater-do-not-edit-or-remove>▲▲▲

SRC		:= $(notdir $(SRCS)) # 				Files only
OBJ		:= $(SRC:.c=.o)	#				Files only
OBJS	:= $(addprefix $(OBJDIR), $(OBJ)) #		Full path
CSRCS	:= $(addprefix ../, $(SRCS)) #			Compiler

GR	= \033[32;1m #	Green
RE	= \033[31;1m #	Red
WI	= \033[33;1m #	Yellow
CY	= \033[36;1m #	Cyan
RC	= \033[0m #	Reset Colors

# ================================== RULES =================================== #

all : $(NAME)

#	linking
$(NAME)	: $(OBJS)
	@printf "$(WI)&&& Linking $(OBJ) to $(NAME)$(RC)"
	$(CC) $(CFLAGS) -o $(NAME) $(OBJS)

#	compiling
$(OBJS) : $(SRCS)
	@printf "$(GR)+++ Compiling $(SRC) to $(OBJ)$(RC)"
	@mkdir -p $(OBJDIR)
	@cd $(OBJDIR) && $(CC) $(CFLAGS) -I ../$(INCDIR) -c $(CSRCS)

#	runnng

run : $(NAME)
	@echo "$(CY)>>> Running $(NAME)$(RC)"
	./$(NAME)
#	cleaning
clean :
	@echo "$(RE)--- Removing $(OBJ)$(RC)"
	@rm -f $(OBJS)

fclean : clean
	@echo "$(RE)--- Removing $(NAME)$(RC)"
	@rm -f $(NAME)

re : fclean all

debug :
	@echo "SRCS $(SRCS)"
	@echo "SRC $(SRC)"
	@echo "OBJS $(OBJS)"
	@echo "OBJ $(OBJ)"
	@echo "CSRCS $(CSRCS)"
	@echo "CFLAGS $(CFLAGS)"

.PHONY	= all run clean fclean re debug
