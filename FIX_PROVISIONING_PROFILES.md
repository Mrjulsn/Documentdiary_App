# Provisioning Profile Problem beheben

## Problem
- Bundle-ID `com.documentdiary.app` existiert bereits ✅
- Extension Bundle-ID wurde erstellt ✅
- Aber Xcode zeigt: "No profiles found" und "no devices" ❌

## Lösung: Manuell Distribution Provisioning Profile erstellen

### Wichtig für Xcode Cloud
Für Xcode Cloud brauchst du **KEINE Geräte**! Du brauchst nur **Distribution Provisioning Profiles** für App Store Distribution.

### Schritt 1: Distribution Provisioning Profile für Haupt-App erstellen

1. **Gehe zu Apple Developer Portal:**
   - https://developer.apple.com/account/resources/profiles/list
   - Melde dich an

2. **Neues Provisioning Profile erstellen:**
   - Klicke auf **"+"** (oben links)
   - Wähle **"App Store"** unter **Distribution** → **Continue**

3. **App ID auswählen:**
   - Wähle **"com.documentdiary.app"** aus der Liste
   - → **Continue**

4. **Zertifikat auswählen:**
   - Wähle ein **"Apple Distribution"** Zertifikat
   - Falls keines vorhanden ist, erstelle eines:
     - Gehe zu: https://developer.apple.com/account/resources/certificates/list
     - **"+"** → **"Apple Distribution"** → **Continue**
     - Folge den Anweisungen
   - → **Continue**

5. **Profil benennen:**
   - **Profile Name:** z.B. `DocumentDiary App Store Distribution`
   - → **Generate**

6. **Profil herunterladen:**
   - Klicke auf **"Download"**
   - Speichere die Datei (endet mit `.mobileprovision`)

### Schritt 2: Distribution Provisioning Profile für Extension erstellen

1. **Wieder "+" klicken:**
   - **"App Store"** → **Continue**

2. **Extension App ID auswählen:**
   - Wähle **"com.documentdiary.app.OneSignalNotificationServiceExtension"**
   - → **Continue**

3. **Gleiches Zertifikat auswählen:**
   - Wähle das gleiche **"Apple Distribution"** Zertifikat
   - → **Continue**

4. **Profil benennen:**
   - **Profile Name:** z.B. `DocumentDiary Extension App Store Distribution`
   - → **Generate**

5. **Profil herunterladen**

### Schritt 3: Provisioning Profiles in Xcode installieren

**Option A: Automatisch (Empfohlen)**
1. Öffne Xcode
2. Gehe zu **Xcode → Settings → Accounts**
3. Wähle dein Apple ID aus
4. Klicke auf **"Download Manual Profiles"**
5. Xcode lädt alle Profile automatisch herunter

**Option B: Manuell**
1. Doppelklicke auf die heruntergeladenen `.mobileprovision` Dateien
2. Sie werden automatisch in Xcode installiert

### Schritt 4: Xcode Projekt aktualisieren

1. **In Xcode:**
   - Gehe zu **Signing & Capabilities** für **WebViewGold** Target
   - **"Automatically manage signing"** sollte aktiviert sein
   - Klicke auf **"Try Again"** oder warte ein paar Sekunden
   - Xcode sollte jetzt das Provisioning Profile finden

2. **Für Extension:**
   - Wähle **OneSignalNotificationServiceExtension** Target
   - Gehe zu **Signing & Capabilities**
   - **"Automatically manage signing"** sollte aktiviert sein
   - Xcode sollte auch hier das Profile finden

### Schritt 5: Xcode Cache leeren (falls nötig)

Falls die Warnungen weiterhin bestehen:

```bash
# Im Terminal:
cd ~/Library/Developer/Xcode/DerivedData
rm -rf *
```

Dann in Xcode:
- **Product → Clean Build Folder** (⇧⌘K)
- Xcode neu starten

## Alternative: Nur für Xcode Cloud (Einfacher)

Falls du nur für Xcode Cloud baust und lokal nicht testen musst:

1. **In Xcode:**
   - **Signing & Capabilities** → **WebViewGold** Target
   - **"Automatically manage signing"** aktiviert lassen
   - **Team:** "JULIUS RUDORFER" auswählen
   - Die Warnungen können ignoriert werden, wenn du nur für Xcode Cloud baust

2. **Xcode Cloud verwendet automatisch:**
   - App Store Distribution Profiles
   - Braucht keine Development Devices
   - Erstellt Profile automatisch, wenn Bundle-IDs registriert sind

## Prüfen ob es funktioniert

1. **In Xcode:**
   - Die Warnungen sollten verschwinden (oder zumindest weniger werden)
   - Unter "Provisioning Profile" sollte "Xcode Managed Profile" stehen

2. **Xcode Cloud:**
   - Starte einen neuen Build
   - Exit Code 70 sollte behoben sein

## Wichtige Hinweise

- ⚠️ **Für Xcode Cloud brauchst du KEINE Geräte!**
- ⚠️ Die Warnung "no devices" ist nur für **Development** Profiles relevant
- ⚠️ **App Store Distribution** Profiles brauchen keine Geräte
- ⚠️ Xcode Cloud erstellt automatisch Distribution Profiles, wenn Bundle-IDs registriert sind

## Falls es weiterhin nicht funktioniert

1. **Prüfe Team-Zuordnung:**
   - Stelle sicher, dass beide Bundle-IDs dem Team `S3C3K89KGM` zugeordnet sind
   - In App Store Connect: https://developer.apple.com/account/resources/identifiers/list
   - Klicke auf jede Bundle-ID und prüfe das Team

2. **Prüfe Zertifikate:**
   - Gehe zu: https://developer.apple.com/account/resources/certificates/list
   - Stelle sicher, dass ein **"Apple Distribution"** Zertifikat existiert
   - Falls nicht, erstelle eines

3. **Xcode Account prüfen:**
   - **Xcode → Settings → Accounts**
   - Stelle sicher, dass dein Apple ID Account korrekt eingeloggt ist
   - Klicke auf **"Download Manual Profiles"**

