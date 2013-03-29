GETROOT := sudo
SHELL := /bin/bash

BINARY_IMAGES := iso hdd netboot
BINARY_STAMPS := $(addprefix output/stamp-,$(BINARY_IMAGES))

BINARY_OUTPUTS_iso := binary.iso binary.iso.zsync
BINARY_OUTPUTS_hdd := binary.img
BINARY_OUTPUTS_netboot := binary.netboot.tar

.PHONY: all
all: $(BINARY_STAMPS) output/stamp-source output/SHA256SUMS.asc

output/SHA256SUMS.asc: output/SHA256SUMS
	gpg -u 0x8FD7D18C -b -a $<

output/SHA256SUMS:
	(cd output && find $(BINARY_IMAGES) source -type f -exec sha256sum -b {} +) > $@

output/stamp-source: $(BINARY_STAMPS)
	mkdir -p output/source_cache
	set -eu; \
		cd output/source_cache; \
		touch .timestamp; \
		d=$$(mktemp -d); \
		trap "rmdir \"$$d\"" EXIT; \
		fail=; \
		while read pkg ver; do \
			pkg=$${pkg%:*}; \
			if ! apt-get --download-only source "$$pkg=$$ver"; then \
				fail="$$pkg=$$ver $$fail"; \
				continue; \
			fi; \
			(cd "$$d" && apt-get -qq --print-uris source "$$pkg=$$ver") | while read url file size hash; do \
				touch "$$file"; \
			done; \
		done < <(sort -u $(foreach o, $(BINARY_IMAGES), ../$(o)/binary.packages <(grep '^Setting up syslinux ' ../$(o)/build.log | awk '{print "syslinux", $$4}' | tr -d '()'))); \
		if [[ -n $$fail ]]; then \
			echo "Failed to get sources for the following packages:"; \
			tr ' ' '\n' <<< $$fail; \
			exit 1; \
		fi
	rm -rf output/source
	mkdir -p output/source
	set -eu; \
		for f in output/source_cache/*; do \
			if [[ $$f -nt output/source_cache/.timestamp ]]; then \
				cp "$$f" output/source/; \
			fi; \
		done
	touch $@

output/stamp-%:
	$(GETROOT) lb clean
	lb config --binary-images $*
	$(GETROOT) lb build
	rm -rf output/$*
	mkdir -p output/$*
	mv -v binary.contents binary.packages build.log $(BINARY_OUTPUTS_$*) output/$*
	touch $@
