from pathlib import Path
import random
import subprocess
import math

WALLPAPER_DIR = Path("~/.dotMess/wallpapers-gruvbox").expanduser()

PALLETE = {
    "bg-diff-red": "#3c1f1e",
    "bg-visual-red": "#442e2d",

    "bg-diff-orange": "#4a2e1a",
    "bg-visual-orange": "#44372a",

    "bg-diff-yellow": "#3f3518",
    "bg-visual-yellow": "#473c29",

    "bg-diff-green": "#32361a",
    "bg-visual-green": "#333e34",

    "bg-diff-aqua": "#1e352d",
    "bg-visual-aqua": "#2d3f35",

    "bg-diff-blue": "#0d3138",
    "bg-visual-blue": "#2e3b3b",

    "bg-diff-purple": "#3f2d35",
    "bg-visual-purple": "#463640"
}

CHOICE_COLORS = {
    "green": {"theme": "Gruvbox-Green-Dark", "icon": "Adwaita-green"},
    "grey": {"theme": "Gruvbox-Grey-Dark", "icon": "Adwaita-slate"},
    "orange": {"theme": "Gruvbox-Orange-Dark", "icon": "Adwaita-orange"},
    "pink": {"theme": "Gruvbox-Pink-Dark", "icon": "Adwaita-Pink"},
    "purple": {"theme": "Gruvbox-Purple-Dark", "icon": "Adwaita-purple"},
    "red": {"theme": "Gruvbox-Red-Dark", "icon": "Adwaita-red"},
    "blue": {"theme": "Gruvbox-Teal-Dark", "icon": "Adwaita-teal"},
    "yellow": {"theme": "Gruvbox-Yellow-Dark", "icon": "Adwaita-yellow"}
}

def hex_to_rgb(hex_color: str):
    hex_color = hex_color.lstrip("#")
    return tuple(int(hex_color[i:i+2], 16) for i in (0, 2, 4))

def color_distance(c1, c2):
    print(f'rgb{c1}, rgb{c2}', end=' ')
    return math.sqrt(sum(abs(a-b)**2 for a, b in zip(c1, c2)))

def extract_colors(wallpaper_path, num_colors=8):
    cmd = [
        "magick", str(wallpaper_path),
        "-resize", "50x50!",
        "-colors", str(num_colors),
        "+dither",
        "-format", "%c\n", "histogram:info:-"
    ]

    out = subprocess.check_output(cmd).decode("utf-8")

    colors = []
    for line in out.splitlines():
        parts = line.strip().split()
        if len(parts) >= 3 and parts[2].startswith("#"):
            colors.append(parts[2])
    return colors

def compare_colors(hex_ext):
    color_diff = []
    for color, hex_val in PALLETE.items():
        current_diff = color_distance(hex_to_rgb(hex_val), hex_to_rgb(hex_ext))
        print(current_diff)
        color_diff.append((color, current_diff))
    return sorted(color_diff, key=lambda x: x[1])

def main():
    wallpapers = [wallpaper for wallpaper in WALLPAPER_DIR.iterdir() if wallpaper.is_file()]
    wallpaper = random.choice(wallpapers)
    color = extract_colors(wallpaper)[-1]
    print(wallpaper, color)

    bg_color = compare_colors(color)
    # color = bg_color.split("-")[-1]

    print(bg_color)

main()