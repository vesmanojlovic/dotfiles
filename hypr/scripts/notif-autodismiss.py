#!/usr/bin/env python3
# Dismiss mako notifications whose app_name matches the newly-focused
# window's class/title, since mako has no native "dismiss on relevant
# window focus" feature. Matching is a loose case-insensitive substring
# check both ways - good enough for apps like Discord/Brave, but won't
# correlate notifications from something run inside a generic terminal
# (window class is just "kitty") unless the terminal's title happens to
# mention the program.

import json
import os
import socket
import subprocess


def matches(app_name, win_class, win_title):
    a = (app_name or "").strip().lower()
    c = (win_class or "").strip().lower()
    t = (win_title or "").strip().lower()
    if not a:
        return False
    return a in c or c in a or a in t


def dismiss_matching(win_class, win_title):
    try:
        out = subprocess.check_output(["makoctl", "list", "-j"], text=True)
        notifs = json.loads(out)
    except Exception:
        return
    for n in notifs:
        if matches(n.get("app_name"), win_class, win_title):
            subprocess.run(["makoctl", "dismiss", "-n", str(n["id"])], check=False)


def main():
    sig = os.environ["HYPRLAND_INSTANCE_SIGNATURE"]
    runtime = os.environ["XDG_RUNTIME_DIR"]
    sock_path = f"{runtime}/hypr/{sig}/.socket2.sock"

    s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    s.connect(sock_path)

    buf = b""
    while True:
        chunk = s.recv(4096)
        if not chunk:
            break
        buf += chunk
        while b"\n" in buf:
            line, buf = buf.split(b"\n", 1)
            text = line.decode(errors="ignore")
            if text.startswith("activewindow>>"):
                payload = text[len("activewindow>>"):]
                win_class, _, win_title = payload.partition(",")
                dismiss_matching(win_class, win_title)


if __name__ == "__main__":
    main()
