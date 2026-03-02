# DCSG2003

## 🦺Robust and Scalable Services

This repository contains a small collection of helper scripts used in the course **DCSG2003 – Robust and Scalable Services**.

The course focuses on how large-scale, fault-tolerant services are built and operated in the real world. Students work with the same types of technologies used by companies like Twitter, Netflix, and Google. The emphasis is **not** on the website itself, but on the infrastructure that keeps it alive.

Throughout the semester, we operate **BookFace**, a distributed web service that must remain online, performant, and resilient. Keeping servers and databases healthy earns appreciation; poor operations cost you.

This repository does **not** contain the full BookFace codebase. Instead, it provides helper utilities that help automate repetitive tasks, keep scripts synchronized, and support general infrastructure work.

---

## ⚙️Outdated Topology

Topolgoy from Week 5

<img width="1136" height="413" alt="image" src="https://github.com/user-attachments/assets/3ed79cf2-89c6-486f-bd1d-fb8ba7bb146e" />


## 🏗️Directory Structure & Requirements

For these utilities to work out of the box, the following layout is expected:

1. The repository is cloned into your home directory:
```
~/DCSG2003/
```

2. All helper scripts live in:
```
~/DCSG2003/scripts/
```

3. Your main operational scripts (the ones running on your server) are stored in:
```
/home/ubuntu/
```
4. Additional automation tools such as the configuration watcher (`check_update.sh`) are also placed in:

```
/home/ubuntu/
```

Some tools rely on utilities like **inotify-tools**, which must be installed for file‑watching functionality.

Short installation guide:
```
sudo apt update
sudo apt install inotify-tools
```


You are free to change this structure if you prefer, just update the paths inside the scripts accordingly.

---

## 🔨Included Tools

#### `update_file`
Compares two files and updates the destination only if the source has changed.  
Useful for keeping multiple directories in sync.

#### `update_scripts`
Iterates through all files in `~/DCSG2003/scripts/` and updates the corresponding files in `/home/ubuntu/`.
This only works if the repository is placed in the expected directory structure described above.

#### `check_if_alive_start.sh`
A monitor script that keeps OpenStack servers alive and restarts the db in necessary 

#### `check_update.sh`
A small file‑watcher utility that automatically reacts whenever our server‑side configuration file changes.

---

## 🔄Loading Functions Automatically

By default, Bash functions only exist in the shell session where they were defined.  
If you want the functions in this repository (such as `update_file` and `update_scripts`) to be available every time you open a terminal, you must load them automatically.

### First-time setup
When you pull this repository for the first time, load all script functions into your shell:

```bash
source ~/DCSG2003/scripts/*
```

### Updating your local scripts
After pulling new changes from Git, update your server-side scripts by running:

```bash
update_scripts
```

## 📄Making Scripts Executable

All helper scripts in this repository must be **executable** before you can run them.  
If a script is not executable Bash will refuse to run it with a “permission denied” error.

### How to make a script executable

Use `chmod +x`:

```bash
chmod +x <script-name>
```

### Making the functions available permanently
To avoid sourcing the scripts manually every time you open a new terminal, add the following lines to your `~/.bashrc`:

```bash
source ~/DCSG2003/scripts/*
```

Then reload your shell:

```bash
source ~/.bashrc
```

From now on, the functions will be available globally without needing to source anything manually.

## 🛠️Adding the `check_if_alive_start.sh` Monitor Script

The script:
- Pings all Ubuntu servers in your OpenStack project  
- Detects when a server is down  
- Starts the server automatically  
- Waits until the VM is reachable again  
- Optionally restarts YugabyteDB on `db1`  
- Logs all actions with timestamps  

This script is designed to run unattended in the background and keep the infrastructure alive.


### Installing the Script

Place the script in:

`/home/ubuntu/check_if_alive_start.sh`

### Running the Script Automatically with Cron

To make the script run periodically (for example, every 5 minutes), add it to your user’s crontab.

Open the crontab editor:

```bash
     crontab -e
```

Add this line:

```bash
    */5 * * * * /home/ubuntu/check_if_alive_start.sh >> /home/ubuntu/logs/check-servers.log 2>&1
```

### What this does

- Runs the script every 5 minutes  
- Appends all output (including errors) to `check-servers.log`  
- Creates the log file automatically if it doesn’t exist  

### Important

Cron runs with a minimal environment so your script must load your OpenStack credentials.  
At the top of the script ensure you have:

`source /home/ubuntu/<your-openstack-rc-file>.sh`

### Viewing Script Output Automatically When You SSH In

If you want to see the latest health‑check results every time you log into the server, add this to your `~/.bashrc`:

```bash
echo "============ check-servers.log ==========="
tail -n 20 /home/ubuntu/logs/check-servers.log
echo "=========================================="
```

Reload your shell:

`source ~/.bashrc`



---

## ⚠️ Note

A significant portion of the BookFace project code is not included here.  
This repository only contains supporting utilities used during the course.
