# Bundle ID Registrierung in App Store Connect - Schritt für Schritt

## Problem
Xcode zeigt Warnungen:
- "No profiles for 'com.documentdiary.app' were found"
- "Communication with Apple failed"

Dies verursacht Exit Code 70 in Xcode Cloud.

## Lösung: Bundle IDs registrieren

### Schritt 1: Haupt-App Bundle ID registrieren

1. **Gehe zu Apple Developer Portal:**
   - https://developer.apple.com/account/resources/identifiers/list
   - Melde dich mit deinem Apple Developer Account an

2. **Neue App ID erstellen:**
   - Klicke auf **"+"** (oben links)
   - Wähle **"App IDs"** → **"Continue"**
   - Wähle **"App"** → **"Continue"**

3. **Details eingeben:**
   - **Description:** `DocumentDiary App`
   - **Bundle ID:** Wähle **"Explicit"** und gib ein: `com.documentdiary.app`
   - ⚠️ **WICHTIG:** Muss exakt übereinstimmen!

4. **Capabilities aktivieren:**
   - Aktiviere die benötigten Capabilities:
     - ✅ Push Notifications (falls verwendet)
     - ✅ Associated Domains (falls verwendet)
     - ✅ Background Modes (falls verwendet)
   - Andere Capabilities nach Bedarf

5. **Registrieren:**
   - Klicke **"Continue"**
   - Überprüfe die Details
   - Klicke **"Register"**

### Schritt 2: Extension Bundle ID registrieren

1. **Wieder "+" klicken:**
   - **"App IDs"** → **"Continue"**
   - **"App"** → **"Continue"**

2. **Details eingeben:**
   - **Description:** `DocumentDiary OneSignal Extension`
   - **Bundle ID:** Wähle **"Explicit"** und gib ein: `com.documentdiary.app.OneSignalNotificationServiceExtension`
   - ⚠️ **WICHTIG:** Muss exakt übereinstimmen mit dem in Xcode!

3. **Capabilities aktivieren:**
   - ✅ Push Notifications (wichtig für Notification Service Extension!)

4. **Registrieren:**
   - **"Continue"** → **"Register"**

### Schritt 3: In Xcode prüfen

1. **In Xcode:**
   - Gehe zu **Signing & Capabilities** für beide Targets
   - Klicke **"Try Again"** bei den Warnungen
   - Oder: **Product → Clean Build Folder** (⇧⌘K)

2. **Erwartetes Ergebnis:**
   - ✅ Keine Warnungen mehr
   - ✅ "Xcode Managed Profile" wird angezeigt
   - ✅ Provisioning Profile wird automatisch erstellt

### Schritt 4: Xcode Cloud Build testen

Nach der Registrierung:
1. Committe alle Änderungen
2. Pushe zu GitHub
3. Starte einen neuen Build in Xcode Cloud
4. Exit Code 70 sollte jetzt behoben sein

## Wichtige Hinweise

- ⚠️ Bundle IDs müssen **exakt** übereinstimmen (Groß-/Kleinschreibung beachten!)
- ⚠️ Extension Bundle ID muss mit der Haupt-App beginnen: `com.documentdiary.app.XXX`
- ⚠️ Nach der Registrierung kann es einige Minuten dauern, bis Xcode die Profile erkennt
- ⚠️ Falls "Try Again" nicht funktioniert, warte 5-10 Minuten und versuche es erneut

## Aktuelle Bundle IDs im Projekt

- **Haupt-App:** `com.documentdiary.app`
- **Extension:** `com.documentdiary.app.OneSignalNotificationServiceExtension`

## Troubleshooting

**Falls die Warnungen weiterhin bestehen:**
1. Prüfe, ob beide Bundle IDs in der Liste erscheinen: https://developer.apple.com/account/resources/identifiers/list
2. Prüfe, ob dein Apple Developer Account aktiv ist
3. Prüfe, ob du die richtige Team-ID verwendest: `S3C3K89KGM`
4. Versuche Xcode neu zu starten
5. Versuche "Automatically manage signing" aus- und wieder einzuschalten


