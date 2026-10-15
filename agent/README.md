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
| `setup.ps1` | Hepsini kök klasöre kopyalar, sıkıştırma ayarını yapar, eksik araçları listeler |

Alt ajanlar `sonnet` modeliyle çalışır: çeviri ve test gibi uzun ama basit işleri daha
ucuz bir modele verip kullanım limitini korur. Ana oturum senin seçtiğin modelde kalır.

## Kurulum (Windows)

1. Ön koşullar zaten kurulu: Claude Code, universal-modder eklentisi, Git, Python, uv, ffmpeg.
2. Repoyu klonla ve kurulum betiğini çalıştır:

```powershell
git clone https://github.com/ferhatsanli/claude-modding "$env:USERPROFILE\claude-modding"
cd "$env:USERPROFILE\claude-modding\agent"
powershell -ExecutionPolicy Bypass -File .\setup.ps1
```

Varsayılan kök klasör `Desktop\Modding`. Başka bir yer için `-Root "D:\Modding"` ekle.

3. Terminali kapatıp yeniden aç, sonra:

```powershell
cd "$env:USERPROFILE\Desktop\Modding"
claude
```

4. İlk açılışta `/agents` ve `/skills` (veya `/` yazınca çıkan liste) ile `verifier`,
   `text-translator`, `new-mod-project` ve `mod-report`'un göründüğünü kontrol et.

## Güncelleme

Repoda bir şeyi değiştirdiğinde:

```powershell
cd "$env:USERPROFILE\claude-modding"
git pull
cd agent
powershell -ExecutionPolicy Bypass -File .\setup.ps1
```

Betik sadece ayar dosyalarının üzerine yazar; `games\` içindeki oyun klasörlerine dokunmaz.

## Eski GBA çalışması

Harry Potter işi `Desktop\Gameboy Advance\work\` altında kaldı ve orada kalabilir. Ona devam
etmek gerekirse, prompt'ta o klasörü proje klasörü olarak vermek yeterli; Claude Code'u yine
modlama kök klasöründe başlat ki kurallar yüklensin.

## Notlar

- `settings.json` içindeki sıkıştırma eşiği bazı sürümlerde uygulanmıyor; bu yüzden
  `setup.ps1` aynı ayarı ortam değişkeni olarak da yapıyor.
- Otomatik izin modunu kendin açıyorsun; `settings.json` sadece onay sorulmadan çalışacak
  komutları ve hiç çalışmayacakları belirler.
