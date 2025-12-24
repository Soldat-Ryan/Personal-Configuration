#!/usr/bin/env python3

import iterm2
import random

<<<<<<< HEAD
EXCLUDED_THEMES = {
    "Regular"
}

=======
>>>>>>> 28621a403818a4bc8332e572f20448b340674187
async def SetPresetInSession(connection, session, preset_name):
    preset = await iterm2.ColorPreset.async_get(connection, preset_name)
    if not preset:
        return
    profile = await session.async_get_profile()
    if not profile:
        return
    await profile.async_set_color_preset(preset)

    # Print Theme name in terminal (need "setopt interactive_comments" in ~/.zshrc)
    await session.async_send_text(f"# 🎨 {preset_name}\n")

async def main(connection):
    app = await iterm2.async_get_app(connection)
    color_preset_names = await iterm2.ColorPreset.async_get_list(connection)
<<<<<<< HEAD
    color_preset_names = [name for name in color_preset_names if name not in EXCLUDED_THEMES]
=======
>>>>>>> 28621a403818a4bc8332e572f20448b340674187
    print(f"✅ {len(color_preset_names)} available color presets")

    # Get theme of the first initial session
    current_window = app.current_terminal_window
    if current_window:
        current_session = current_window.current_tab.current_session
        if current_session:
            initial_theme = random.choice(color_preset_names)
            print(f"🎨 Initial session : {initial_theme}")
            await SetPresetInSession(connection, current_session, initial_theme)

    # Watch new sessions
    async with iterm2.NewSessionMonitor(connection) as mon:
        while True:
            session_id = await mon.async_get()
            session = app.get_session_by_id(session_id)
            if session:
                theme = random.choice(color_preset_names)
                print(f"🎨 {theme}")
                await SetPresetInSession(connection, session, theme)

iterm2.run_forever(main)