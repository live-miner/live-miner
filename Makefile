GETROOT := sudo
SHELL := /bin/bash

SOURCE := false

.PHONY: binary
binary:
	$(GETROOT) lb clean
	lb config --source $(SOURCE)
	time $(GETROOT) lb build
