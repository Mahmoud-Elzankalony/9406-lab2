
dir ?= dir
malicious_dir ?= malicious_dir
interval_secs ?= 5

.PHONY: pre-build runs_antivirusd run_restore

pre-build:
	mkdir -p "$(malicious_dir)"
	touch Whitelist.txt

runs_antivirusd: pre-build
	bash antivirusd.sh "$(dir)" "$(malicious_dir)" "$(interval_secs)"

run_restore:
	bash restore.sh "$(dir)" "$(malicious_dir)" 
