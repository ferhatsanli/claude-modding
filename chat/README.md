# chat/ — Modding projesinin ayarları

Bu klasördeki her dosya, Claude Desktop'ta **Projects > Modding** ayarlarındaki bir kutuya karşılık gelir. Dosyanın içeriğini kopyalayıp ilgili kutuya yapıştır.

| Dosya | Hangi kutu | Not |
| --- | --- | --- |
| [`01-name.txt`](01-name.txt) | Proje adı | |
| [`02-description.txt`](02-description.txt) | Proje açıklaması | Kısa, sadece senin için |
| [`03-instructions.md`](03-instructions.md) | Proje talimatları (Instructions) | En önemli dosya; tamamını yapıştır |
| [`04-knowledge/`](04-knowledge/) | Proje bilgisi (Knowledge / Files) | İçindeki dosyaları **yükle**, yapıştırma |
| [`05-memory.md`](05-memory.md) | Projenin hafıza ayarı | Önerilen seçim ve nedeni |
| [`06-skills/`](06-skills/) | Hesap ayarlarındaki Skills bölümü | Projeye değil hesabına eklenir |

## Knowledge dosyaları

- `environment.md` — bilgisayarın, kurulu araçlar ve klasör yapın. Bir şey kurduğunda veya taşıdığında güncelle.
- `agent-prompt-template.md` — ajan prompt'larının iskeleti.
- `platforms.md` — platformlara göre (GBA, PC/Skyrim) kısa notlar.
- `games/` — her oyun için bir özet. Bir oyunun işi bitince ajanın `PLAN.md` dosyasından kısa bir özet buraya eklenir.

## Skill

`06-skills/mod-prompt-planner/` klasörünü zip'leyip (klasörün kendisi zip'in içinde olacak şekilde) hesap ayarlarındaki Skills bölümünden yükle. Bu skill, sohbette yaptığımız "fikri dinle → formla sor → özetle → onay al → prompt'u yaz" akışını her seferinde aynı şekilde yürütür.
