#!/usr/bin/env python3
# swaync only picks the focused output when it creates a fresh popup surface —
# once one exists it's reused for later notifications even after focus moves
# to another monitor (confirmed live 2026-07-21: notifications kept landing on
# the monitor of the *first* toast, not the currently active one). Hyprland's
# IPC has no live "move this surface" hook, so instead we hide any current
# popup the moment focus changes monitor; the next notification then creates
# a brand new surface, which swaync correctly anchors on the now-focused
# output. Only hides the transient popup — history in the panel is untouched.
import os
import socket
import subprocess

sock_path = os.path.join(
    os.environ["XDG_RUNTIME_DIR"],
    "hypr",
    os.environ["HYPRLAND_INSTANCE_SIGNATURE"],
    ".socket2.sock",
)

last_monitor = None

with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as sock:
    sock.connect(sock_path)
    buf = b""
    while True:
        data = sock.recv(4096)
        if not data:
            break
        buf += data
        while b"\n" in buf:
            line, buf = buf.split(b"\n", 1)
            text = line.decode(errors="ignore")
            if text.startswith("focusedmon>>"):
                monitor = text.split(">>", 1)[1].split(",", 1)[0]
                if monitor != last_monitor:
                    last_monitor = monitor
                    subprocess.run(["swaync-client", "--hide-all"])
