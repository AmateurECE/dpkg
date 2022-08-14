#!/usr/bin/make -f
###############################################################################
# NAME:		    Makefile
#
# AUTHOR:	    Ethan D. Twardy <ethan.twardy@gmail.com>
#
# DESCRIPTION:	    Top-level makefile for the application.
#
# CREATED:	    08/14/2022
#
# LAST EDITED:	    08/14/2022
###

# Empty all rule to allow to be called with no arguments
all:

# Install the service. Note: This will overwrite the symlinked unit
# /usr/lib/systemd/user/ssh-agent.service, which is installed by the
# openssh-client package. This unit is more useful than the one provided by
# that package, which is why this is okay.
install:
	install -d $(DESTDIR)/lib/systemd/user
	install -m644 ssh-agent.service $(DESTDIR)/lib/systemd/user

###############################################################################
