#!/usr/bin/env bash

set -euo pipefail

format_bindings() {
    hyprctl binds | awk '
        function modifiers(mask) {
            result = ""
            if (and(mask, 8)) result = "Super"
            if (and(mask, 4)) result = result (result ? " + " : "") "Ctrl"
            if (and(mask, 1)) result = result (result ? " + " : "") "Shift"
            if (and(mask, 64)) result = result (result ? " + " : "") "Meta"
            return result
        }

        function key_name(key, mask) {
            if (key == "Return") return "Enter"
            if (key == "escape") return "Escape"
            if (key == "space") return "Space"
            if (key == "left") return "Left"
            if (key == "right") return "Right"
            if (key == "up") return "Up"
            if (key == "down") return "Down"
            if (key == "slash" && and(mask, 1)) return "?"
            if (key == "mouse:272") return "Left Mouse Drag"
            if (key == "mouse:273") return "Right Mouse Drag"
            if (key == "XF86AudioRaiseVolume") return "Volume Up"
            if (key == "XF86AudioLowerVolume") return "Volume Down"
            if (key == "XF86AudioMute") return "Mute"
            if (key == "XF86AudioPlay") return "Play/Pause"
            if (key == "XF86AudioNext") return "Media Next"
            if (key == "XF86AudioPrev") return "Media Previous"
            if (length(key) == 1) return toupper(key)
            return key
        }

        function emit(    mask, mods, key, desc, category, action, separator, combo) {
            if (!active) return

            mask = fields["modmask"] + 0
            mods = modifiers(mask)
            key = key_name(fields["key"], mask)

            # The question mark already communicates Shift in the rendered key.
            if (key == "?") sub(/ \+ Shift$/, "", mods)

            combo = mods ? mods " + " key : key
            if (fields["submap"] != "") combo = "Resize: " combo

            desc = fields["description"]
            separator = index(desc, ": ")
            if (separator) {
                category = substr(desc, 1, separator - 1)
                action = substr(desc, separator + 2)
            } else {
                category = "Other"
                action = desc
                if (action == "") {
                    action = fields["dispatcher"]
                    if (fields["arg"] != "") action = action " " fields["arg"]
                }
            }

            printf "%-24s  →  %s\t%s\t%s\t%s\n", combo, action, category, \
                fields["dispatcher"], fields["arg"]
            delete fields
            active = 0
        }

        /^[a-z]+$/ {
            emit()
            active = 1
            next
        }

        active && /^\t[a-z]+: / {
            name = substr($0, 2, index($0, ":") - 2)
            value = substr($0, index($0, ":") + 2)
            fields[name] = value
        }

        END { emit() }
    '
}

if [[ ${1:-} == "--print" ]]; then
    format_bindings | awk -F '\t' '{ print $1 }'
    exit 0
fi

selection=$(
    format_bindings | rofi \
        -dmenu \
        -i \
        -matching fuzzy \
        -no-custom \
        -display-columns 1 \
        -display-column-separator $'\t' \
        -p "Keybindings" \
        -mesg "Search by key, action, or category; Enter launches applications" \
        -config "$HOME/.config/rofi/config.rasi" \
        -theme "$HOME/.config/rofi/keybindings.rasi" \
        || true
)

[[ -n $selection ]] || exit 0

IFS=$'\t' read -r _ category dispatcher argument <<< "$selection"
if [[ $category == "Applications" && $dispatcher == "exec" ]]; then
    hyprctl dispatch exec "$argument"
fi
