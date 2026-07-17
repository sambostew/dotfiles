#!/usr/bin/env python3
"""Generate a fastfetch logo that displays an image via kitty graphics
Unicode placeholders (U=1). Placeholder cells are ordinary text, so the
image scrolls, persists in scrollback, and is overwritten by TUIs instead
of floating above them like normal kitty-protocol placements.

Emits TWO files (keeping the bulky transmission out of the logo keeps
fastfetch's layout math sane):
  <name>-transmit.kitty  - chunked APC that uploads the image (zero visible
                           output; cat from .zshrc before running fastfetch)
  <name>-placeholder.txt - the placeholder cell grid, used as the fastfetch
                           "file-raw" logo

Usage: gen-placeholder-logo.py <image> <columns> <rows> <output-basename>
e.g.:  gen-placeholder-logo.py ~/Pictures/goku.jpeg 55 16 ~/dotfiles/.config/fastfetch/goku
"""
import base64
import io
import sys

from PIL import Image

# Verified against kitty gen/rowcolumn-diacritics.txt (first 20 entries).
DIACRITICS = [
    0x0305, 0x030D, 0x030E, 0x0310, 0x0312, 0x033D, 0x033E, 0x033F,
    0x0346, 0x034A, 0x034B, 0x034C, 0x0350, 0x0351, 0x0352, 0x0357,
    0x035B, 0x0363, 0x0364, 0x0365,
]
PLACEHOLDER = chr(0x10EEEE)
IMAGE_ID = 42  # encoded in the cells' 256-color foreground

image, cols, rows, base = sys.argv[1], int(sys.argv[2]), int(sys.argv[3]), sys.argv[4]
assert rows <= len(DIACRITICS), 'extend DIACRITICS for more rows'

buf = io.BytesIO()
im = Image.open(image)
if im.width > 1024:  # logo renders ~930px wide; don't ship full-res data
    im = im.resize((1024, im.height * 1024 // im.width), Image.LANCZOS)
im.save(buf, 'PNG')  # f=100 requires PNG data
data = base64.b64encode(buf.getvalue()).decode()

chunks = [data[i:i + 4096] for i in range(0, len(data), 4096)]
parts = []
for n, chunk in enumerate(chunks):
    m = 0 if n == len(chunks) - 1 else 1
    keys = f'i={IMAGE_ID},f=100,t=d,a=T,U=1,q=2,c={cols},r={rows},m={m}' if n == 0 else f'm={m}'
    parts.append(f'\033_G{keys};{chunk}\033\\')
open(f'{base}-transmit.kitty', 'w').write(''.join(parts))

lines = []
for row in range(rows):
    lines.append(f'\033[38;5;{IMAGE_ID}m'
                 + PLACEHOLDER + chr(DIACRITICS[row]) + chr(DIACRITICS[0])
                 + PLACEHOLDER * (cols - 1)
                 + '\033[39m\n')
open(f'{base}-placeholder.txt', 'w').write(''.join(lines))
