GETROOT := sudo

.PHONY: binary
binary:
	$(GETROOT) lb clean
	lb config
	time -p $(GETROOT) lb build
