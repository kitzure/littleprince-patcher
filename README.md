# Prince 3-in-1 Fix — 星願外傳 Starwish Legend / 星願小王子 / 星願歷奇
### One package that unlocks the full version of all three games

三個遊戲，一個修復包。同一個資料夾、同一個伺服器、同一個啟動器。

---

## 1. What's in here / 內容

```
Prince-3in1-Fix/
├── Start_Server.bat         Windows: the local server (elevates itself)
├── Start_Server.sh          Linux: the local server
├── Revert_Hosts.bat         Windows: manual hosts clean-up (normally not needed)
├── fake_server.py           ONE local server for all three games (port 80)
├── README.md                this file
└── games/                   the patched files, one folder per game
    ├── 1-Starwish-Legend/    reg.swf  index.swf  start.swf
    ├── 2-Little-Prince/      reg.swf
    └── 3-Prince-Adventure/   reg.swf  login.swf
```

Installing a patch is a **copy**: take the files from `games/<game>/` and drop
them into the game folder — the one that has `start.exe` in it.

安裝方法就係**複製**：將 `games/<遊戲>/` 入面嘅檔案放入遊戲 folder（有 `start.exe` 嗰個）。

---

## 2. Quick start / 快速開始

### Windows

1. Copy the whole `Prince-3in1-Fix` folder anywhere (Desktop is fine).
2. Copy the patched files into your game folder (keep a backup of the originals):

   | Your game | Copy from | Into the folder with `start.exe` |
   |-----------|-----------|----------------------------------|
   | 星願外傳 / Kingdom CD | `games/1-Starwish-Legend/` | `reg.swf` `index.swf` `start.swf` |
   | 星願小王子 | `games/2-Little-Prince/` | `reg.swf` |
   | 星願歷奇 | `games/3-Prince-Adventure/` | `reg.swf` `login.swf` |

   Not sure which one you have? The folder contents give it away: `index.zinc` →
   1, `book.swf` / `inst.swf` / `comp.swf` → 2, `gamea1.swf` → 3.
3. Double-click **`Start_Server.bat`** (accept the administrator prompt) and
   leave the window open — it adds the hosts redirect for you.
4. Start the game (`start.exe`). It opens in **full version**.
5. When you are done playing, close the server window / press Ctrl+C and the
   hosts file is reverted automatically.

### Linux / Wine

```bash
cd ~/Downloads/prince-3in1-fix
./play_3in1.sh /path/to/game        # patch + start
```

Or do it by hand — this is the exact sequence that was verified:

```bash
# 1. install the patched files (back up the originals first)
cp games/2-Little-Prince/reg.swf  "/path/to/game/"

# 2. start the local server (adds the hosts redirect, needs root for port 80)
sudo python3 fake_server.py

# 3. in another terminal, run the game
cd "/path/to/game" && wine start.exe
```

**The hosts redirect must be active while you play.** `fake_server.py` adds it
on start and **removes it again when you stop the server** — you do not have to
run `Revert_Hosts.bat` / edit `/etc/hosts` yourself any more. The revert happens
on every way of stopping it:

| How you stop the server | Hosts reverted? |
|-------------------------|-----------------|
| `Ctrl+C` | yes (signal handler) |
| Closing the console window (the X) | yes — a Windows console-control handler catches `CTRL_CLOSE`; on Linux closing the terminal sends `SIGHUP`/`SIGTERM` |
| Normal exit / crash of the main loop | yes (`atexit`) |
| Force-kill (`taskkill /F`, `kill -9`, PC power cut) | no — the process gets no chance to clean up. `Start_Server.bat` runs the revert right after Python exits, so a `taskkill` of *Python* is still covered; for `kill -9` use `Revert_Hosts.bat` / `sed` below |

`Start_Server.bat` runs the revert again after Python exits and prints
`hosts file reverted - normal web browsing restored.` `play_3in1.sh` starts the
server detached, so the server's own handler does the revert when you stop it.
If the server was started without admin/root it never touched the hosts file at
all (it says so in its log: `hosts: cannot write …`).

---

## 3. What each patch actually does / 修復原理

| Game | Files patched | What changed |
|------|---------------|--------------|
| **1. Starwish Legend** (星願外傳) | `reg.swf`, `index.swf`, `start.swf` | the green 啟動遊戲 button calls `_root.loadFullVersion()` directly instead of the serial-check flow; `loadTrialVersion()` is forced to `cdsingle` and the demo user is no longer created |
| **2. Little Prince** (星願小王子) | `reg.swf` | `reg.swf` overrides `activationSuccess()` (always true) and `getHDKey()` (constant), then writes the activation record through `saveActivation()`. The game then boots straight into the full version. The registration form itself is left untouched. |
| **3. Prince Adventure** (星願歷奇) | `reg.swf`, `login.swf` | green button → `Prince3.PrinceSystem.loadOpening()` (the exact call made after a successful activation), plus the same `activationSuccess` override so account saving (`applicationSaveRecord`) is not silently blocked |

Every one of the three games talks to the same official endpoint:
`http://www.little-prince.com.hk/littleprince/amfservice/gateway.php`
— that is why **one** fake server and **one** hosts redirect can serve all
three at once.

`fake_server.py` answers:
* `checkVersion` → `0.0,,`  → never "newer" than the local build, so the
  "please update" popup never appears (safe for all three games)
* `checkActivation` → `e000,e000`; `activation` / `reactivation` /
  anything unknown → `e000`
* `validate.php` → `valid=true`
* any GET (the online ping) → `network=1&status=ok`

---

## 4. Why the redirect is not optional (錯誤:091)

The official backend is still online. If the game is allowed to reach it,
`checkActivation` gets answered with **`e091`**, and the client reacts with

```
錯誤:091　這部電腦的啟動資料不正確，
系統會刪除現存的啟動資料，並將立即關閉…
```

i.e. it shows the 091 error and **deletes its activation data**. That is
exactly what happens when the hosts redirect is missing — even with the patch
installed. So:

* if you see 錯誤:091 → the redirect/server is not active, or the game started
  before the server did;
* start `fake_server.py` (it prints `hosts: added 4 redirect lines …`), then
  start the game.

---

## 5. More options / 其他用法

```
play_3in1.sh /path/to/game          patch + start the server + run the game
play_3in1.sh --dry /path/to/game    show the plan, change nothing
play_3in1.sh --patch-only /path     patch only, no server, no launch
play_3in1.sh --restore /path        put the original files back
```

On Windows the patches are plain file copies (see §2) and
`Start_Server.bat` takes care of the server + hosts file.

`fake_server.py` options: `python fake_server.py [port] [--no-hosts]`
(`--no-hosts` leaves the hosts file completely alone).

**Undo at any time:** keep a copy of the original files before you copy the
patches over them (or use `play_3in1.sh --restore` on Linux, which keeps its
backup in `<game folder>/_original_backup/`). Nothing else in the game folder
is ever changed, and no file is deleted.

---

## 6. Troubleshooting / 疑難排解

**The game shows 錯誤:091**
The redirect is not in place (see §4). Start `fake_server.py` first — it needs
admin/root; if it says `hosts: cannot write …` it was started without rights.

**"Requesting administrator rights" then nothing happens**
Some antivirus tools block the self-elevation (PowerShell `Start-Process`).
Right-click the `.bat` → *Run as administrator*.

**The game still shows an activation / trial screen**
Make sure you copied the patch into the folder that actually contains
`start.exe` — for some packages that is the inner `content` folder, not the
outer one.

**"Python not found"**
Only the local server needs Python. Without it the games are patched but the
redirect cannot be added.

**Port 80 already in use**
Something else (IIS, a web server) owns port 80. Run
`python fake_server.py 8080` and ask me to repoint the SWFs.

**Antivirus / SmartScreen warning about the server**
`fake_server.py` edits the hosts file to send `little-prince.com.hk` to
`127.0.0.1`, which looks exactly like an ad-blocker hijack to a scanner.
It only adds four `127.0.0.1 …` lines; read the file, it is plain text.
Those same lines are removed again when the server stops.

**Reverting the hosts file by hand (rarely needed)**
```bash
# Linux
sudo sed -i '/little-prince\|sunnyinteractive/d' /etc/hosts
# Windows (run as admin)
notepad C:\Windows\System32\drivers\etc\hosts   # delete the little-prince.com.hk / sunnyinteractive.com lines
```
or run `Revert_Hosts.bat` (Windows) / `play_3in1.sh --restore`.

---

## 7. Verified

* Game 2 (星願小王子) checked **in the running game** on Linux/Wine:
  `validate.php → valid=true`, `checkActivation → e000,e000`, no 錯誤:091, the
  game plays its opening animation (full version, no trial banner, no
  activation form), and `lic.dat` is written to
  `C:\Users\Public\Documents\Little Prince\Little Prince\` and kept.
* The 091 failure reproduced and explained: without the redirect the game
  reaches the live backend, which answers `checkActivation` with `e091`.
* `fake_server.py` re-tested with real AMF packets: `checkVersion`,
  `checkActivation`, `activation`, an unknown method, `validate.php` and the
  GET ping — all correct.
* Hosts handling tested both ways: lines added when missing, lines already
  present (added by the launcher) are still removed on exit.

Backups of the original, unmodified files ship inside the individual fix
folders you already have (`kingdom-fixed/`, `lp-fixed/`, `pa-fixed/`).
