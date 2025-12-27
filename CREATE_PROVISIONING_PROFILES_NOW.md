# Provisioning Profiles JETZT erstellen - Schritt für Schritt

## Problem
✅ Build erfolgreich  
❌ Export fehlgeschlagen (Exit Code 70)  
❌ Fehlende Provisioning Profiles für Extension

## Lösung: Manuell Provisioning Profiles erstellen

### Schritt 1: Apple Distribution Zertifikat prüfen/erstellen

1. **Gehe zu:**
   - https://developer.apple.com/account/resources/certificates/list
   - Melde dich mit deinem Apple Developer Account an

2. **Prüfe ob "Apple Distribution" Zertifikat existiert:**
   - Suche nach **"Apple Distribution"** in der Liste
   - Falls vorhanden → weiter zu Schritt 2
   - Falls NICHT vorhanden → erstelle eines:

3. **Neues Zertifikat erstellen (falls nötig):**
   - Klicke **"+"** (oben links)
   - Wähle **"Apple Distribution"** unter **Software**
   - → **Continue**
   - Folge den Anweisungen (Certificate Signing Request erstellen)
   - Lade das Zertifikat herunter und installiere es (Doppelklick)

---

### Schritt 2: Provisioning Profile für Haupt-App erstellen

1. **Gehe zu:**
   - https://developer.apple.com/account/resources/profiles/list

2. **Neues Profil erstellen:**
   - Klicke **"+"** (oben links)
   - Unter **Distribution** wähle **"App Store"**
   - → **Continue**

3. **App ID auswählen:**
   - Wähle **"com.documentdiary.app"** aus der Dropdown-Liste
   - → **Continue**

4. **Zertifikat auswählen:**
   - Wähle dein **"Apple Distribution"** Zertifikat
   - (Sollte nur eines zur Auswahl stehen)
   - → **Continue**

5. **Profil benennen:**
   - **Profile Name:** `DocumentDiary App Store`
   - → **Generate**

6. **Profil herunterladen:**
   - Klicke auf **"Download"** (rechts neben dem Profil)
   - Speichere die Datei (z.B. auf dem Desktop)
   - **WICHTIG:** Merke dir wo du sie gespeichert hast!

---

### Schritt 3: Provisioning Profile für Extension erstellen

1. **Wieder "+" klicken:**
   - **"App Store"** unter Distribution
   - → **Continue**

2. **Extension App ID auswählen:**
   - Wähle **"com.documentdiary.app.OneSignalNotificationServiceExtension"** aus der Liste
   - → **Continue**

3. **Gleiches Zertifikat auswählen:**
   - Wähle das gleiche **"Apple Distribution"** Zertifikat
   - → **Continue**

4. **Profil benennen:**
   - **Profile Name:** `DocumentDiary Extension App Store`
   - → **Generate**

5. **Profil herunterladen:**
   - Klicke auf **"Download"**
   - Speichere die Datei

---

### Schritt 4: Provisioning Profiles in Xcode installieren

**Methode 1: Automatisch (Empfohlen)**

1. **Öffne Xcode**
2. Gehe zu: **Xcode → Settings** (oder **Preferences**)
3. Klicke auf den Tab **"Accounts"**
4. Wähle dein Apple ID aus der Liste
5. Klicke auf **"Download Manual Profiles"** Button
6. Xcode lädt alle Profile automatisch herunter

**Methode 2: Manuell (Falls Methode 1 nicht funktioniert)**

1. **Finde die heruntergeladenen Dateien:**
   - Sie enden mit `.mobileprovision`
   - Z.B.: `DocumentDiary_App_Store.mobileprovision`

2. **Installiere die Profile:**
   - **Doppelklicke** auf jede `.mobileprovision` Datei
   - Sie werden automatisch in Xcode installiert
   - Du siehst eine Bestätigung: "Profile installed"

---

### Schritt 5: Xcode Projekt aktualisieren

1. **Öffne dein Projekt in Xcode:**
   - `/Users/juliusrudorfer/Desktop/Documentdiary /Webview Gold /WebViewGold/Version15.4LTS/XcodeSourceCode/WebViewGold.xcodeproj`

2. **Für Haupt-App (WebViewGold Target):**
   - Klicke links auf das blaue Projekt-Icon
   - Wähle das Target **"WebViewGold"**
   - Gehe zu Tab **"Signing & Capabilities"**
   - ✅ **"Automatically manage signing"** sollte aktiviert sein
   - **Team:** "JULIUS RUDORFER" sollte ausgewählt sein
   - Unter **"Provisioning Profile"** sollte jetzt **"Xcode Managed Profile"** oder dein Profil stehen
   - Falls Warnungen da sind, klicke **"Try Again"**

3. **Für Extension (OneSignalNotificationServiceExtension Target):**
   - Wähle das Target **"OneSignalNotificationServiceExtension"**
   - Gehe zu Tab **"Signing & Capabilities"**
   - ✅ **"Automatically manage signing"** sollte aktiviert sein
   - **Team:** "JULIUS RUDORFER" sollte ausgewählt sein
   - Unter **"Provisioning Profile"** sollte jetzt **"Xcode Managed Profile"** oder dein Profil stehen
   - Falls Warnungen da sind, klicke **"Try Again"**

---

### Schritt 6: Xcode Cache leeren (Optional, aber empfohlen)

1. **In Xcode:**
   - **Product → Clean Build Folder** (oder ⇧⌘K)

2. **Im Terminal (Optional):**
   ```bash
   rm -rf ~/Library/Developer/Xcode/DerivedData/*
   ```

3. **Xcode neu starten**

---

### Schritt 7: Xcode Cloud Build testen

1. **Änderungen committen (falls nötig):**
   ```bash
   cd "/Users/juliusrudorfer/Desktop/Documentdiary /Webview Gold /WebViewGold/Version15.4LTS/XcodeSourceCode"
   git add .
   git commit -m "Provisioning profiles configured"
   git push origin main
   ```

2. **In Xcode Cloud:**
   - Gehe zu deinem Workflow
   - Starte einen neuen Build
   - Exit Code 70 sollte jetzt behoben sein! ✅

---

## Checkliste

- [ ] Apple Distribution Zertifikat existiert oder wurde erstellt
- [ ] Provisioning Profile für `com.documentdiary.app` erstellt und heruntergeladen
- [ ] Provisioning Profile für `com.documentdiary.app.OneSignalNotificationServiceExtension` erstellt und heruntergeladen
- [ ] Beide Profile in Xcode installiert (via "Download Manual Profiles" oder Doppelklick)
- [ ] In Xcode: Beide Targets haben "Automatically manage signing" aktiviert
- [ ] In Xcode: Beide Targets zeigen das richtige Team
- [ ] Xcode Cache geleert
- [ ] Neuer Xcode Cloud Build gestartet

---

## Falls es weiterhin nicht funktioniert

1. **Prüfe ob beide Bundle-IDs registriert sind:**
   - https://developer.apple.com/account/resources/identifiers/list
   - Beide sollten in der Liste erscheinen

2. **Prüfe ob beide Profile erstellt wurden:**
   - https://developer.apple.com/account/resources/profiles/list
   - Beide sollten **"Active"** Status haben

3. **Prüfe Team-Zuordnung:**
   - Stelle sicher, dass beide Bundle-IDs dem Team `S3C3K89KGM` zugeordnet sind

4. **Xcode Cloud Logs prüfen:**
   - Lade die vollständigen Build-Logs herunter
   - Suche nach spezifischen Fehlermeldungen zu Provisioning Profiles

---

## Wichtige URLs

- **Certificates:** https://developer.apple.com/account/resources/certificates/list
- **Identifiers:** https://developer.apple.com/account/resources/identifiers/list
- **Profiles:** https://developer.apple.com/account/resources/profiles/list
- **App Store Connect:** https://appstoreconnect.apple.com

