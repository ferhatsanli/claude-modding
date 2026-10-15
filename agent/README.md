# agent/ — Claude Code kurulumu

Bu klasör, bilgisayarındaki **modlama kök klasörünün** içeriğidir. Claude Code'u o klasörde
başlattığında ajan buradaki kuralları, skill'leri ve alt ajanları otomatik yükler. Böylece
sohbetten gelen prompt'lar sadece o oyuna özel kısmı içerir.

## İçerik

| Yol | Ne işe yarar |
| --- | --- |
| `CLAUDE.md` | Her oturumda okunan kurallar: otonom çalışma, ne zaman sorulacağı, orijinallere dokunmama, token kuralları, PLAN.md, rapor |
| `.claude/settings.json` | İzinler (sık kullanılan komutlar onaysız çalışır, tehlikeli olanlar yasak) ve sıkıştırma eşiği |
| `.claude/skills/new-mod-project/` | Yeni bir oyun için klasör, notlar ve güvenli kopyaları kurar |
| `.claude/skills/mod-report/` | İş bitince kısa raporu yazar ve notları günceller |
| `.claude/agents/verifier.md` | Bitmiş modu, onu yapmamış ayrı bir ajan olarak test eder |
| `.claude/agents/text-translator.md` | Çeviri işini partiler halinde, ana bağlamı şişirmeden yapar |
| `templates/` | `PLAN.md` ve oyun başına `CLAUDE.md` şablonları |
| `games/` | Her oyunun klasörü buraya açılır (git'e girmez) |
| `setup-win.ps1` | Windows kurulumu (PowerShell, winget) |
| `setup-mac.sh` | macOS kurulumu (Homebrew) |
| `setup-linux.sh` | Linux kurulumu (Fedora `dnf`, Debian/Ubuntu `apt`, Arch `pacman`) |
| `setup-android.sh` | Android'de Termux kurulumu (`pkg`) |
| `setup-common.sh` | Üç Unix betiğinin ortak adımları; tek başına çalıştırılmaz |

Her kurulum betiği aynı işi yapar: ayarları kök klasöre kopyalar, sıkıştırma eşiğini
ortam değişkeni olarak ayarlar, `um` aracını kurar ve eksik araçları listeler. İsteğe bağlı
olarak araçları da o platformun paket yöneticisiyle kurar.

Alt ajanlar `sonnet` modeliyle çalışır: çeviri ve test gibi uzun ama basit işleri daha
ucuz bir modele verip kullanım limitini korur. Ana oturum senin seçtiğin modelde kalır.

## Hangi platformda ne yapılır

| Platform | Ne için uygun |
| --- | --- |
| Windows | Her şey. PC oyunları (Skyrim) ve `um win` gibi Windows araçları sadece burada çalışır. |
| macOS, Linux | Emülatörlü işler (GBA ROM'ları, mGBA), metin/çeviri işleri, scriptler, notlar. |
| Android (Termux) | Uzaktan plan, not ve hafif script işleri. Emülatör ve oyun testi için uygun değil. |

Aynı oyunu birden fazla cihazda çalışacaksan oyun klasörünü (ör. bulut klasörü veya
ayrı bir git deposu ile) senkronize etmen gerekir; bu repo oyun dosyalarını taşımaz.

## Kurulum

Repo her platformda aynı şekilde klonlanır, sonra o platformun betiği çalıştırılır.
`INSTALL_TOOLS=1` (Windows'ta `-InstallTools`) araçları da kurar; zaten kuruluysa gerek yok.

### Windows (PowerShell)

```powershell
git clone https://github.com/ferhatsanli/claude-modding "$env:USERPROFILE\claude-modding"
cd "$env:USERPROFILE\claude-modding\agent"
powershell -ExecutionPolicy Bypass -File .\setup-win.ps1
# with tools and a custom root:
powershell -ExecutionPolicy Bypass -File .\setup-win.ps1 -InstallTools -Root "D:\Modding"
```

Varsayılan kök: `Desktop\Modding`.

### macOS (Terminal)

```bash
git clone https://github.com/ferhatsanli/claude-modding ~/claude-modding
cd ~/claude-modding/agent
bash setup-mac.sh
# with tools (needs Homebrew) and a custom root:
INSTALL_TOOLS=1 bash setup-mac.sh ~/Desktop/Modding
```

Varsayılan kök: `~/Modding`. Ortam değişkeni `~/.zshrc` dosyasına eklenir.

### Linux (Fedora ve diğerleri)

```bash
git clone https://github.com/ferhatsanli/claude-modding ~/claude-modding
cd ~/claude-modding/agent
bash setup-linux.sh
# with tools (uses sudo) and a custom root:
INSTALL_TOOLS=1 bash setup-linux.sh ~/Games/Modding
```

Varsayılan kök: `~/Modding`. Fedora'da ana depolardaki `ffmpeg-free` kurulur; tam ffmpeg
gerekirse RPM Fusion'dan kurulabilir.

### Android (Termux)

```bash
pkg install -y git
git clone https://github.com/ferhatsanli/claude-modding ~/claude-modding
cd ~/claude-modding/agent
INSTALL_TOOLS=1 bash setup-android.sh
# root on phone storage (run termux-setup-storage once first):
bash setup-android.sh ~/storage/shared/Modding
```

Termux'un kendi paket yöneticisi (`pkg`) ve depoları olduğu için ayrı bir betiği var.
Claude Code zaten kuruluysa atlanır; değilse resmi `curl` kurulumu kullanılır (npm sadece o
başarısız olursa yedek).

### Kurulumdan sonra (her platform)

Yeni bir terminal aç, kök klasöre gidip `claude` ile başlat. Eklenti kurulu değilse
Claude Code içinde:

```text
/plugin marketplace add rehan-remade/universal-modder
/plugin install universal-modder@universal-modder
```

İlk açılışta `/agents` ve `/` listesiyle `verifier`, `text-translator`, `new-mod-project`
ve `mod-report`'un göründüğünü kontrol et.

## Güncelleme

Repoda bir şeyi değiştirdiğinde, o cihazda:

```bash
cd ~/claude-modding && git pull && cd agent
bash setup-<mac|linux|android>.sh            # Windows: .\setup-win.ps1
```

Betikler sadece ayar dosyalarının üzerine yazar; `games/` içindeki oyun klasörlerine dokunmaz.
Varsayılan olmayan bir kök kullandıysan aynı yolu tekrar ver.

## Eski GBA çalışması

Harry Potter işi Windows'ta `Desktop\Gameboy Advance\work\` altında kaldı ve orada kalabilir.
Ona devam etmek gerekirse, prompt'ta o klasörü proje klasörü olarak vermek yeterli; Claude
Code'u yine modlama kök klasöründe başlat ki kurallar yüklensin.

## Notlar

- `settings.json` içindeki sıkıştırma eşiği bazı sürümlerde uygulanmıyor; bu yüzden
  kurulum betikleri aynı ayarı ortam değişkeni olarak da yapıyor.
- Otomatik izin modunu kendin açıyorsun; `settings.json` sadece onay sorulmadan çalışacak
  komutları ve hiç çalışmayacakları belirler.
