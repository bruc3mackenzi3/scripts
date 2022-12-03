# Shell Environment Configuration
Scripts to configure and automate the initialization of a Shell environment

## Quickstart
Results in:
* Creates / appends to `.bash_profile` with references to:
  * Custom profile.sh
  * Custom aliases.sh

## Configure Environment with Go
Before running the install script:
* Manually edit version, OS, install path

```bash
./go_install.sh
```

Before running the init script:
- Modify GOROOT PATH entry in `bash/profile.sh`

```bash
./init.sh
```

## Updating
This project attempts to be idempotent, meaning subsequent installs will produce the same result.  To that end, an option asks for user input to overwrite or append to an existing `.bash_profile.sh`.

### TODO
* Move init.sh, OSX/init.sh to init/ folder
* Move PATH initialization from global to env-specific scope, i.e. remove OSX-specific paths from other environments
* Make inclusion of `quickplay_profile.sh` conditional
