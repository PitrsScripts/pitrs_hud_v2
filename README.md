# pitrs_hud_v2

pitrs-hud is a dynamic and immersive heads-up display system built for both ESX and QBCore frameworks. With a modern design and full voice system integration, it offers real-time player status, minimap customization, voice proximity, and more — all synced with the server to ensure data persistence and RP immersion.


<img width="437" height="350" alt="image" src="https://github.com/user-attachments/assets/687c6fc1-3635-4587-a65c-bddad1028073" />

### ✨ Features
🧠 Live Player Status Sync

Health, armor, hunger, thirst, stamina, and oxygen all update in real time

Syncs with the server on disconnect, reconnect, or spawn

Automatically saves on resource stop or player drop

### 🎤 Voice Integration with PMA-Voice

Voice proximity display: Whisper, Normal, Shouting

Talking indicator synced with actual voice activity

Toggle modes with customizable keybind (F11 by default)

### 🗺️ Custom Minimap & Compass

Repositioned minimap for modern layout

Directional compass (North, East, etc.) based on player heading

Auto-toggle minimap when entering or exiting a vehicle

### 📍 Live Location Display

Shows current street and area/zone name

Auto-updates every half second for accuracy

### 🆔 Server ID Display

Shows your current server ID directly on the HUD

### ⏸️ Pause Menu Integration

Automatically hides HUD when pause menu is open

Seamless fade in/out when resuming gameplay

### 🛠️ Framework-Agnostic Design

Fully supports ESX and QBCore

Automatically detects and adapts to the active framework

Uses MySQL or player metadata to store health and armor

### 🧩 Modular & Configurable

Easily toggle HUD visibility with /hud

Fully expandable — ready for job icons, money display, or other stats



### 📦 Resource Info

|||
| --- | --- |
|**Code is accessible**|Yes|
|**Subscription-based**|No|
|**Lines (approximately)**|~933|
|**Requirements**|ox_lib,oxmysql,esx/qb,pma-voice,esx_status,esx_basicneeds|
|**Support**|Yes|
