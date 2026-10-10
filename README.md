# Antivirus Daemon

## Overview
This project is a simple Bash antivirus that monitors a directory, detects potentially malicious files, and moves them to a quarantine directory. It also allows users to restore or delete quarantined files.

## Requirements
- Linux
- Bash
- Make

## Project Files
- `antivirusd.sh`: Scans files and monitors the directory.
- `restore.sh`: Restores or deletes quarantined files.
- `Makefile`: Provides commands to run the scripts.
- `Whitelist.txt`: Stores filenames that should be skipped during scanning.

## How to Run

Open the terminal in the project directory.

### 1. Run the Antivirus

```bash
make runs_antivirusd dir=dir malicious_dir=malicious_dir interval_secs=5
```

- `dir`: Directory to monitor.
- `malicious_dir`: Directory for quarantined files.
- `interval_secs=5`: Checks for directory changes every 5 seconds.

The antivirus scans the directory at startup, then checks for changes periodically. Press `Ctrl+C` to stop it.

### 2. Restore or Delete Files

Open a terminal in the project directory and run:

```bash
make run_restore dir=dir malicious_dir=malicious_dir
```

Choose an action from the menu to restore a file, delete it permanently, or skip it.

**Note:** Stop the antivirus before restoring files to avoid scanning them during restoration.

### 3. Run Without Make

You can also run the scripts directly:

```bash
bash antivirusd.sh dir malicious_dir 5
```

```bash
bash restore.sh dir malicious_dir
```

## Detection Rules

The antivirus flags files with these extensions:

`.exe`, `.bat`, `.vbs`, `.scr`, `.ps1`

It also checks file contents for these words, ignoring case:

`virus`, `trojan`, `malware`, `worm`, `ransomware`

Detected files are copied to `malicious_dir` and the originals are deleted only if copying succeeds.

## Whitelist (Bonus 2)

When a file is restored using `restore.sh`, its filename is added to `Whitelist.txt`. The antivirus checks this file before scanning and skips whitelisted filenames.

The whitelist is saved on disk, so it remains available after restarting the antivirus.

## Notes

- Create the `dir` directory and put files inside it before testing.
- The antivirus scans files directly inside `dir`, not its subdirectories.
- The Makefile creates `malicious_dir` and ensures `Whitelist.txt` exists.
