# claude-modding

Claude ile oyun modlama çalışmaları için ayarlar ve şablonlar.

İki katman var ve birbirlerinin ayarlarını görmezler:

| Klasör | Ne için | Nerede kullanılır |
| --- | --- | --- |
| [`chat/`](chat/) | Planlama ve prompt yazma | Claude Desktop / claude.ai, **Projects > Modding** ayarları |
| [`agent/`](agent/) | Asıl modlama işini yapan ajan | Bilgisayarındaki **Claude Code** (terminal) |

Tipik akış:

1. Yeni bir oyun fikrini **Modding** projesinde bir sohbette konuşursun. Claude eksikleri formla sorar, kararları özetler, onayından sonra ajan prompt'unu yazar.
2. Prompt'u Claude Code'a yapıştırırsın. Ajan, `agent/` klasöründen kurulan kuralları (CLAUDE.md, skill'ler, alt ajanlar) zaten bildiği için prompt sadece o oyuna özel kısmı içerir.
3. Ajanın raporunu tekrar sohbete getirirsin; düzeltme prompt'u orada yazılır.

Kurulum talimatları her klasörün kendi README dosyasında.
