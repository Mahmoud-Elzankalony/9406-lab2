dir ?= source_dir
malicious_dir ?= malicious_dir
interval_secs ?= 5

pre-build:
	mkdir -p $(malicious_dir)

runs_antivirusd : pre-build
	bash antivirusd.sh $(dir) $(malicious_dir) $(interval_secs)

run_restore:
    bash restore.sh $(dir) $(malicious_dir) 
