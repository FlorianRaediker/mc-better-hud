import glob
import json


INCLUDE_KEYS = [
    "%1074992263$s",  # resource pack check; multiple keys start with this
    "bingo.technical.detect_multiplayer",
    "bingo.custom_hud.",
    "bingo.preferences.",
    "bingo.resourcepack_check."
]

EXCLUDE_KEYS = [
    "bingo.resourcepack_check.sign.",
    "bingo.resourcepack_check.go_to_lobby.part2",
    "bingo.resourcepack_check.go_to_lobby.click",
    "bingo.resourcepack_check.wrong_version.sign.",
    "bingo.preferences.custom_hud.adjust_card.",
    "bingo.custom_hud.components.seed",
    "bingo.preferences.title",
    "bingo.preferences.description",
    "bingo.preferences.spectator_mode.",
    "bingo.preferences.custom_hud.component_settings.seed."
]

for filename in glob.glob("*.json"):
    with open(filename, "r") as f:
        lang = json.load(f)
    
    lang = {key: value for key, value in lang.items() 
            if any(key.startswith(inc) for inc in INCLUDE_KEYS) and all(not key.startswith(exc) for exc in EXCLUDE_KEYS)}
    
    with open(filename, "w") as f:
        json.dump(lang, f, ensure_ascii=False, indent="\t")
