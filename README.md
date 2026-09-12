![ai gen banner lol](banner.jpeg)
<p align="center">ignore that ai gen banner</p>

# littleprince-patcher

A patcher that patches the game to playable version 

- Starwish Legend
- Little Prince
- Prince Adventure

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

## Disclaimer

This project is for educational and preservation purposes only. These are long-discontinued Flash games still answers with an error, and this package exists so that people who already own a copy can keep playing it on their own machine.

* Please respect the company. All games, artwork, music, characters and code belong to their developers and publishers. Nothing here claims any right over them.
* Do not sell or bundle this package commercially, and do not use it for piracy \u2014 no serial keys, licences or game downloads are provided here.
* Own the game first. Apply the patches only to a copy you legally own, and keep a backup of the original files.
* Support the official release if the company ever makes these games available again.
* If a rights holder asks, this repository should be removed.

