this repo is just a personal fork of the original repository


# dwl - dwm for Wayland

Join us on our IRC channel: [#dwl on Libera Chat]  
Or on the community-maintained [Discord server].

dwl is a compact, hackable compositor for [Wayland] based on [wlroots]. It is
intended to fill the same space in the Wayland world that [dwm] does in X11,
primarily in terms of functionality, and secondarily in terms of
philosophy. Like [dwm], dwl is:

- Easy to understand, hack on, and extend with patches
- One C source file (or a very small number) configurable via `config.h`
- Tied to as few external dependencies as possible

## Getting Started:

### Building dwl
dwl has the following dependencies:
- libinput
- wayland
- wlroots (compiled with the libinput backend)
- xkbcommon
- wayland-protocols (compile-time only)
- pkg-config (compile-time only)

dwl has the following additional dependencies if XWayland support is enabled:
- libxcb
- libxcb-wm
- wlroots (compiled with X11 support)
- Xwayland (runtime only)

Install these (and their `-devel` versions if your distro has separate
development packages) and run `make`. If you wish to build against a released
version of wlroots (*you probably do*), use a [release] or a [0.x branch]. If
you want to use the unstable development `main` branch, you need to use the git
version of [wlroots].

To enable XWayland, you should uncomment its flags in `config.mk`.

## Configuration

All configuration is done by editing `config.h` and recompiling, in the same
manner as [dwm]. There is no way to separately restart the window manager in
Wayland without restarting the entire display server, so any changes will take
effect the next time dwl is executed.

As in the [dwm] community, we encourage users to share patches they have
created. Check out the [dwl-patches] repository!

## Running dwl

dwl can be run on any of the backends supported by wlroots. This means you can
run it as a separate window inside either an X11 or Wayland session, as well as
directly from a VT console. Depending on your distro's setup, you may need to
add your user to the `video` and `input` groups before you can run dwl on a
VT. If you are using `elogind` or `systemd-logind` you need to install polkit;
otherwise you need to add yourself in the `seat` group and enable/start the
seatd daemon.

When dwl is run with no arguments, it will launch the server and begin handling
any shortcuts configured in `config.h`. There is no status bar or other
decoration initially; these are instead clients that can be run within the
Wayland session. Do note that the default background color is grey. This can be
modified in `config.h`.

If you would like to run a script or command automatically at startup, you can
specify the command using the `-s` option. This command will be executed as a
shell command using `/bin/sh -c`.  It serves a similar function to `.xinitrc`,
but differs in that the display server will not shut down when this process
terminates. Instead, dwl will send this process a SIGTERM at shutdown and wait
for it to terminate (if it hasn't already). This makes it ideal for execing into
a user service manager like [s6], [anopa], [runit], [dinit], or [`systemd
--user`].

Note: The `-s` command is run as a *child process* of dwl, which means that it
does not have the ability to affect the environment of dwl or of any processes
that it spawns. If you need to set environment variables that affect the entire
dwl session, these must be set prior to running dwl. For example, Wayland
requires a valid `XDG_RUNTIME_DIR`, which is usually set up by a session manager
such as `elogind` or `systemd-logind`.  If your system doesn't do this
automatically, you will need to configure it prior to launching `dwl`, e.g.:

    export XDG_RUNTIME_DIR=/tmp/xdg-runtime-$(id -u)
    mkdir -p $XDG_RUNTIME_DIR
    dwl

### Status information

Information about selected layouts, current window title, app-id, and
selected/occupied/urgent tags is written to the stdin of the `-s` command (see
the `STATUS INFORMATION` section in `_dwl_(1)`).  This information can be used to
populate an external status bar with a script that parses the
information. Failing to read this information will cause dwl to block, so if you
do want to run a startup command that does not consume the status information,
you can close standard input with the `<&-` shell redirection, for example:

    dwl -s 'foot --server <&-'

If your startup command is a shell script, you can achieve the same inside the
script with the line

    exec <&-

To get a list of status bars that work with dwl consult our [wiki].

