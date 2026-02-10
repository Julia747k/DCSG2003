# DCSG2003

## Robust and Scalable Services

This repository contains a small collection of helper scripts used in the course **DCSG2003 – Robust and Scalable Services**.

The course focuses on how large-scale, fault-tolerant services are built and operated in the real world. Students work with the same types of technologies used by companies like Twitter, Netflix, and Google. The emphasis is **not** on the website itself, but on the infrastructure that keeps it alive.

Throughout the semester, we operate **BookFace**, a distributed web service that must remain online, performant, and resilient. Keeping servers and databases healthy earns appreciation; poor operations cost you.

This repository does **not** contain the full BookFace codebase. Instead, it provides helper utilities that help automate repetitive tasks, keep scripts synchronized, and support general infrastructure work.

---

## Directory Structure & Requirements

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

You are free to change this structure if you prefer—just update the paths inside the scripts accordingly.

---

## Included Tools

### `update_file`
Compares two files and updates the destination only if the source has changed.  
Useful for keeping multiple directories in sync.

### `update_scripts`
Iterates through all files in `~/DCSG2003/scripts/` and updates the corresponding files in `/home/ubuntu/`.
This only works if the repository is placed in the expected directory structure described above.

---

## Loading Functions Automatically

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

---

## ⚠️ Note

A significant portion of the BookFace project code is not included here.  
This repository only contains supporting utilities used during the course.
