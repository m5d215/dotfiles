#!/usr/bin/env bash
# Update tmux window name with Claude Code agent status indicator.
#
# Usage (from settings.json hooks):
#   tmux-claude-status.sh submit   # … running
#   tmux-claude-status.sh stop     # ✓ done
#   tmux-claude-status.sh perm     # ! permission request

set -Ceuo pipefail

readonly INDICATOR_RUNNING='…'
readonly INDICATOR_STOPPED='✓'
readonly INDICATOR_PERM='!'

# inactive pill (dark bg #313244) → bright fg
readonly STYLE_RUNNING='fg=#fab387'
readonly STYLE_STOPPED='fg=#a6e3a1,bold'
readonly STYLE_SEEN='fg=#6c7086'
readonly STYLE_PERM='fg=#f38ba8,bold'
# active pill (bright bg #cba6f7) → dark fg
readonly STYLE_RUNNING_CURRENT='fg=#45475a'
readonly STYLE_STOPPED_CURRENT='fg=#1e1e2e,bold'
readonly STYLE_SEEN_CURRENT='fg=#1e1e2e,bold'
readonly STYLE_PERM_CURRENT='fg=#1e1e2e,bold'

readonly HOOK_NAME='pane-focus-in'

_base_name() {
    tmux display-message -t "$TMUX_PANE" -p '#{window_name}' \
    | sed "s/^[$INDICATOR_RUNNING$INDICATOR_STOPPED$INDICATOR_PERM] //"
}

_update() {
    local _name
    _name=$(_base_name)
    tmux rename-window -t "$TMUX_PANE" "$1 $_name"
    tmux set-option -w -t "$TMUX_PANE" window-status-style "$2"
    tmux set-option -w -t "$TMUX_PANE" window-status-current-style "$3"
}

_set_focus_hook() {
    tmux set-hook -w -t "$TMUX_PANE" "$HOOK_NAME" \
        "set-option -w window-status-style '$STYLE_SEEN' ; set-option -w window-status-current-style '$STYLE_SEEN_CURRENT' ; set-hook -uw $HOOK_NAME"
}

_clear_focus_hook() {
    tmux set-hook -uw -t "$TMUX_PANE" "$HOOK_NAME" 2>/dev/null || true
}

case $1 in
    submit)
        _clear_focus_hook
        _update "$INDICATOR_RUNNING" "$STYLE_RUNNING" "$STYLE_RUNNING_CURRENT"
        ;;
    stop)
        _update "$INDICATOR_STOPPED" "$STYLE_STOPPED" "$STYLE_STOPPED_CURRENT"
        _set_focus_hook
        ;;
    perm)
        _clear_focus_hook
        _update "$INDICATOR_PERM" "$STYLE_PERM" "$STYLE_PERM_CURRENT"
        ;;
    *)
        echo "usage: ${0##*/} {submit|stop|perm}"
        exit 1
        ;;
esac
