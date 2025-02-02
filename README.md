# Orbit

## Roadmap

- [ ] Options menu
- [ ] More sfx
- [ ] More music
- [ ] Unlocables
- [ ] More asteroids type

## Commands

### Pakage

```bash
npx love-packager package
```

### Web

```bash
npx https://github.com/Davidobot/love.js ./dist/{version}/orbit-{version}.love orbit-{version}-Web
```

### linux

```bash
./dist/{version}/orbit-{version}.AppImage --appimage-extract
nvim ./dist/{version}/squashfs-root/AppRun # line 30, 32 change "$APPDIR/bin/love" "$APPDIR/bin/{game name}"
appimagetool ./dist/{version}/squashfs-root/ ./dist/{version}/orbit-{version}-Linux.AppImage
```
