# transcript-cleaner

> ⚡️ Convert SRT / WEBVTT / TXT transcripts into a compact one‑liner format
>
> **Input**
> ```
> 1
> 00:04:46.360 --> 00:04:49.779
> Alice: Hello there.
> ```
>
> **Output**
> ```
> [00:04:46]Alice: Hello there.
> ```

---

## 🚀 Features

* Supports **SRT** and **WEBVTT** (header automatically ignored)
* Ignores cue indices, trims whitespace, and drops milliseconds ⇒ `[hh:mm:ss]`
* Works with mixed/CRLF new‑lines
* Tiny footprint – pure Swift & SwiftPM only

---

## 📦 Installation

### 1. Using [Mint](https://github.com/yonaskolb/Mint) (Recommended)
                    
```bash
# install Mint (if you don’t have it already)
brew install mint

# install the tool from GitHub
mint install salescore-inc/transcript-cleaner

# you can now run it 🤖
trim --help
```

> Mint caches the built binary, so subsequent installs & updates are super‑fast.

### 2. Manual build

```bash
git clone https://github.com/salescore-inc/transcript-cleaner.git
cd transcript-cleaner
swift build -c release
sudo cp .build/release/trim /usr/local/bin/
```

---

## 🛠 Usage

```bash
# basic: read from file and output to stdout
trim talk.srt > clean.txt

# or pipe from stdin
cat talk.vtt | trim
```

The output is a simple, single‑line format:
    
    ```
    [hh:mm:ss]Name: body text…
```

* **hh:mm:ss** – cue start timestamp (milliseconds removed)
* **Name: body** – caption text on the same line

> Tip: redirect the output straight into your note‑taking app or further CLI processing (grep, awk, etc.).

---

## 🔬 Development

```bash
# run unit tests (Swift Testing)
swift test

# build & run from source
swift run trim sample.vtt
```

### Updating the CLI name
The executable name is defined in **Package.swift**:
    ```swift
.products = [ .executable(name: "trim", targets: ["Trim"]) ]
```
Change `"trim"` if you’d like a different command.

---

## 📄 License

MIT © 2025 Salescore Inc.
                    
