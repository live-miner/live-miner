GETROOT := sudo
SHELL := /bin/bash

BINARY_IMAGES := iso-hybrid
SOURCE := false

.PHONY: binary
binary:
	$(GETROOT) lb clean
	lb config --source $(SOURCE) --binary-images $(BINARY_IMAGES)
	time $(GETROOT) lb build
