# Prince 3-in-1 fix

Full-version unlock for three Flash CD games that share one activation server:

- Starwish Legend (Kingdom CD)
- Little Prince
- Prince Adventure

All three post to `http://www.little-prince.com.hk/littleprince/amfservice/gateway.php`.
That server is still online and answers `checkActivation` with `e091`, and the
game reacts by showing the "activation data incorrect" **error 091** dialog,
deleting its activation data and closing. The fix is patched SWFs plus a local
server that answers `e000` instead, while the hosts file points the official
domains at `127.0.0.1`.

## Windows

1. Copy the files from `games/<your game>/` into the game folder (the one with
   `start.exe`). Keep a backup of the originals.
2. Double-click `Start_Server.bat`, accept the admin prompt, leave the window open.
3. Start the game.
4. When you are done, Ctrl+C or just close the server window - the hosts file is
   reverted automatically.

Which game is which: `index.zinc` -> Starwish Legend, `book.swf` / `inst.swf` /
`comp.swf` -> Little Prince, `gamea1.swf` -> Prince Adventure.

## Linux / Wine

```bash
./play_3in1.sh /path/to/game        # patch + start everything
# or by hand:
sudo python3 fake_server.py         # adds the hosts redirect, Ctrl+C reverts it
cd /path/to/game && wine start.exe
```

## Notes

* The hosts redirect has to be active while playing. Without it the game reaches
  the real server, gets `e091` and wipes its activation data.
* `fake_server.py` adds four `127.0.0.1` lines on start and removes them again on
  Ctrl+C, on closing the window and on normal exit. Only a force-kill
  (`kill -9`, `taskkill /F`, power cut) leaves them behind - then run
  `Revert_Hosts.bat`, or on Linux:
  `sudo sed -i '/little-prince\|sunnyinteractive/d' /etc/hosts`
* Server options: `python fake_server.py [port] [--no-hosts]`
* Tested on Linux/Wine: the Little Prince patch boots the full version (no trial
  banner, no activation form) and writes `lic.dat` to
  `C:\Users\Public\Documents\Little Prince\Little Prince\`.
