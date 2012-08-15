GETROOT := sudo
SHELL := /bin/bash

.PHONY: binary
binary:
	$(GETROOT) lb clean
	lb config
	time $(GETROOT) lb build
