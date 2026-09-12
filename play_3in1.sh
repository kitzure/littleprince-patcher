#!/usr/bin/env bash
# =====================================================================
#  Prince 3-in-1 Full-Version Fix  --  Linux / Wine version
#  ONE script for all three games:
#     1. Kingdom CD   2. Little Prince   3. Prince Adventure
#
#  Usage:
#     ./play_3in1.sh                       # auto-detect from this folder
#     ./play_3in1.sh /path/to/game         # patch that game + run
#     ./play_3in1.sh --restore /path/game  # put the originals back
#     ./play_3in1.sh --dry /path/game      # show the plan, change nothing
#     ./play_3in1.sh --patch-only /path    # patch only, no server / no launch
# =====================================================================
set -u

PKG="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODE=play
GAMEDIR=""

for arg in "$@"; do
  case "$arg" in
    --dry|-n)        MODE=dry ;;
    --restore|-r)    MODE=restore ;;
    --patch-only|-p) MODE=patch ;;
    --help|-h)       MODE=help ;;
    *)               GAMEDIR="$arg" ;;
  esac
done

echo "====================================================================="
echo "   Prince 3-in-1 Fix  -  one package, three games"
echo "   1. Kingdom CD    2. Little Prince    3. Prince Adventure"
echo "====================================================================="
echo

if [ "$MODE" = help ]; then
  sed -n '2,13p' "$0" | sed 's/^# \{0,1\}//'
  exit 0
fi

find_game() {
  local d candidate
  for d in "$@"; do
    [ -n "$d" ] || continue
    candidate="${d%/}"
    if [ -f "$candidate/start.exe" ]; then echo "$candidate"; return 0; fi
    if [ -f "$candidate/content/start.exe" ]; then echo "$candidate/content"; return 0; fi
  done
  return 1
}

if [ -z "$GAMEDIR" ]; then
  GAMEDIR="$(find_game "$PKG" "$PWD" || true)"
fi
if [ -z "$GAMEDIR" ]; then
  echo "No game folder found here."
  echo "Pass it explicitly, e.g.:  ./play_3in1.sh ~/Games/'Kingdom CD'"
  exit 1
fi
GAMEDIR="$(find_game "$GAMEDIR" || echo "$GAMEDIR")"

if [ ! -f "$GAMEDIR/start.exe" ]; then
  echo "[ERROR] $GAMEDIR has no start.exe - wrong folder."
  exit 1
fi

GAME=""
if   [ -f "$GAMEDIR/index.zinc" ];      then GAME=1-Kingdom-CD
elif [ -f "$GAMEDIR/gamea1.swf" ] || [ -f "$GAMEDIR/index_hung.zinc" ]; then GAME=3-Prince-Adventure
elif [ -f "$GAMEDIR/book.swf" ] || [ -f "$GAMEDIR/inst.swf" ] || [ -f "$GAMEDIR/comp.swf" ]; then GAME=2-Little-Prince
fi

echo "Game folder : $GAMEDIR"
if [ -z "$GAME" ]; then
  echo "[ERROR] Could not recognise the game (expected index.zinc / book.swf / gamea1.swf)."
  exit 1
fi
echo "Detected    : $GAME"
echo "Mode        : $MODE"
echo

PATCHDIR="$PKG/games/$GAME"
BACKUPDIR="$GAMEDIR/_original_backup"

if [ "$MODE" = restore ]; then
  [ -d "$BACKUPDIR" ] || { echo "[ERROR] no backup at $BACKUPDIR"; exit 1; }
  for f in "$BACKUPDIR"/*.swf; do
    [ -e "$f" ] || continue
    cp -f "$f" "$GAMEDIR/$(basename "$f")"
    echo "   restored  $(basename "$f")"
  done
  exit 0
fi

if [ "$MODE" = dry ]; then
  echo "[DRY RUN] backup to : $BACKUPDIR"
  echo "[DRY RUN] copy from : $PATCHDIR"
  for f in "$PATCHDIR"/*.swf; do [ -e "$f" ] && echo "            * $(basename "$f")"; done
  echo "[DRY RUN] hosts     : www.little-prince.com.hk, little-prince.com.hk,"
  echo "                      www.sunnyinteractive.com, file.sunnyinteractive.com -> 127.0.0.1"
  echo "[DRY RUN] server    : python3 fake_server.py 80"
  echo "[DRY RUN] launch    : wine $GAMEDIR/start.exe"
  exit 0
fi

[ -d "$PATCHDIR" ] || { echo "[ERROR] patch files missing: $PATCHDIR"; exit 1; }

mkdir -p "$BACKUPDIR"
echo "Backing up originals to $BACKUPDIR ..."
for f in "$PATCHDIR"/*.swf; do
  [ -e "$f" ] || continue
  name="$(basename "$f")"
  [ -f "$BACKUPDIR/$name" ] || cp -f "$GAMEDIR/$name" "$BACKUPDIR/$name" 2>/dev/null || true
  cp -f "$f" "$GAMEDIR/$name"
  echo "   patched   $name"
done
echo

if [ "$MODE" = patch ]; then
  echo "Patched. Skipping hosts / server / launch (--patch-only)."
  exit 0
fi

echo "Pointing the official server domains at this PC ..."
if grep -qi "little-prince.com.hk" /etc/hosts 2>/dev/null; then
  echo "   hosts entries already present"
else
  echo "   need sudo to add the hosts entries. Run this in your own terminal:"
  echo
  echo "     sudo tee -a /etc/hosts >/dev/null <<'EOF'"
  echo "     127.0.0.1 www.little-prince.com.hk"
  echo "     127.0.0.1 little-prince.com.hk"
  echo "     127.0.0.1 www.sunnyinteractive.com"
  echo "     127.0.0.1 file.sunnyinteractive.com"
  echo "     EOF"
  echo
fi

if pgrep -f "fake_server.py" >/dev/null 2>&1; then
  echo "Fake server already running."
else
  echo "Starting the shared fake server (port 80 needs root) ..."
  if [ "$(id -u)" -eq 0 ]; then
    (cd "$PKG" && nohup python3 fake_server.py >/dev/null 2>&1 &)
    sleep 2
  else
    echo "   run this in your own terminal if you want it:"
    echo "     sudo python3 $PKG/fake_server.py"
  fi
fi

echo
echo "Starting the game ..."
(cd "$GAMEDIR" && nohup wine start.exe >/dev/null 2>&1 &)
echo
echo "Done. Press the green button to play the FULL version."
echo "Undo with:  $0 --restore \"$GAMEDIR\""
