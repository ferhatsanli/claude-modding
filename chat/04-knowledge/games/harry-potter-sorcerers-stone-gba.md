# Harry Potter and the Sorcerer's Stone (GBA)

Status: done (Turkish translation + cheats menu v2).

## Version
- USA release, game code AHRE, maker 69 (Electronic Arts), 8 MB.
- CRC32 F755065C, SHA-1 40D3F693E444192C94A0FF3CD9ED5F64162AC777.
- Source: `C:\Users\Ferhat\Desktop\Gameboy Advance\ROM\0173 - Harry Potter and the Sorcerer's Stone (U)(Lightforce).zip`
- A second file with the same name ending in `-alt-00` exists; always ignored.

## Outputs (in `C:\Users\Ferhat\Desktop\Gameboy Advance\work\output\`)
- `Harry Potter and the Sorcerer's Stone (TR).gba` — full Turkish translation.
- `... (TR) (GPot).gba` — v1 cheats (superseded; Invincible bug).
- `... (TR) (GPot) v2.gba` — current.

## Findings
- No decomp or text tools existed; the knowledge base had nothing. Text is in a custom
  format; found by RAM tracing in mGBA.
- Stamina in this game is health; "Infinite Stamina" = "Infinite Health".
- CodeBreaker key was recovered mathematically; 6 of 9 codes decrypted. Health, Stars and
  Invincibility codes did not decrypt; star counter never found.
- Spells are cycled with R and cast with B.
- Invincible v1 bug: holding a timer field in Harry's object non-zero blocked all
  interactions and cutscenes. v2 skips the collision-damage handler for Harry instead.

## Cheats menu (v2)
Options screen > "Hileler" submenu, headers non-selectable, cursor wraps:
- `-- Buyuler --` Ghost (noclip, semi-transparent, can't turn off inside a wall),
  Invincible (no damage, no knockback)
- `-- Karakter --` Sonsuz Can, Yavas Cekim Tusu (hold L)
- `-- Kilit Ac --` Maksimum Bina Puani, Tum Buyuler, Tum Esyalar, Tum Kartlar
  (one-shot, show "Aktif" until reset)
- Tum Hileleri Kapat (keeps Ghost on while inside a wall; leaves Kilit Ac lines alone)
- Language screen shows "Turkce" with a Turkish flag.

## Known limits
- Using a Kilit Ac line on the title Options screen and then loading a save: the save
  overwrites the values but the line still shows "Aktif". Use the in-game pause menu.
  Possible fix: hide those lines on the title screen.
- Agent tested saving by calling the save routine directly, not via normal play.
