# Xcode Cloud Exit Code 70 - Lösungsvorschläge

## Problem
Der Build schlägt in Xcode Cloud mit Exit Code 70 während des Archive-Exports fehl, obwohl er lokal funktioniert.

## Was bereits behoben wurde
✅ **Development Team konsistent:** Beide Targets (WebViewGold und OneSignalNotificationServiceExtension) verwenden jetzt dasselbe Team: `S3C3K89KGM`

## Mögliche Ursachen und Lösungen

### 1. Bundle Identifiers in App Store Connect registrieren (WICHTIG!)

**Problem:** Xcode Cloud benötigt, dass ALLE Bundle Identifiers (Haupt-App UND Extensions) in App Store Connect registriert sind, bevor automatische Provisioning Profiles erstellt werden können.

**Lösung:**
1. Gehe zu https://appstoreconnect.apple.com
2. Navigiere zu: **Certificates, Identifiers & Profiles** → **Identifiers**
3. Stelle sicher, dass folgende Bundle IDs registriert sind:
   - `com.documentdiary.app` (Haupt-App)
   - `com.documentdiary.app.OneSignalNotificationServiceExtension` (Extension)
4. Falls die Extension-Bundle-ID fehlt:
   - Klicke auf **"+"** → **App IDs**
   - Wähle **App** als Typ
   - Gib `com.documentdiary.app.OneSignalNotificationServiceExtension` ein
   - Aktiviere **Push Notifications** (falls benötigt)
   - Speichere

### 2. App Store Connect API Zugriff aktivieren

**Problem:** Xcode Cloud benötigt manchmal expliziten Zugriff auf die App Store Connect API.

**Lösung:**
1. Gehe zu https://appstoreconnect.apple.com
2. Navigiere zu: **Users and Access** → **Keys**
3. Stelle sicher, dass ein API-Key existiert oder erstelle einen neuen
4. In Xcode Cloud Workflow-Einstellungen:
   - Überprüfe, ob der API-Key korrekt konfiguriert ist

### 3. Provisioning Profiles überprüfen

**Problem:** Abgelaufene oder inkompatible Provisioning Profiles können Exit Code 70 verursachen.

**Lösung:**
1. Gehe zu https://developer.apple.com/account/resources/profiles/list
2. Überprüfe alle Provisioning Profiles für:
   - `com.documentdiary.app`
   - `com.documentdiary.app.OneSignalNotificationServiceExtension`
3. Falls Profile abgelaufen sind:
   - Erstelle neue Profile
   - Oder lass Xcode Cloud automatisch neue Profile erstellen (empfohlen)

### 4. Xcode Version in Xcode Cloud

**Problem:** Bestimmte Xcode-Versionen haben bekannte Probleme mit Code Signing in Xcode Cloud.

**Lösung:**
1. In Xcode Cloud Workflow-Einstellungen:
   - Überprüfe die verwendete Xcode-Version
   - Falls möglich, wechsle zu einer stabileren/neueren Version
   - Oder teste mit einer älteren Version, falls die aktuelle Probleme hat

### 5. ExportOptions.plist (Optional)

**Hinweis:** Ich habe eine `ExportOptions.plist` Datei erstellt, aber bei automatischer Signierung sollte diese normalerweise nicht benötigt werden. Falls das Problem weiterhin besteht, kann diese Datei helfen.

**Falls nötig:**
- Die Datei liegt bereits im Projektverzeichnis
- Xcode Cloud sollte sie automatisch verwenden, falls vorhanden

## Nächste Schritte

### Sofort zu prüfen:
1. ✅ **Bundle IDs registrieren:** Stelle sicher, dass beide Bundle IDs in App Store Connect registriert sind
2. ✅ **App Store Connect API:** Überprüfe den API-Zugriff
3. ✅ **Xcode Cloud Workflow:** Überprüfe die Workflow-Einstellungen

### Debugging:
1. **Build-Logs herunterladen:**
   - In Xcode Cloud: Klicke auf den fehlgeschlagenen Build
   - Lade die vollständigen Logs herunter
   - Suche nach spezifischen Fehlermeldungen zu:
     - Code Signing
     - Provisioning Profiles
     - Bundle Identifiers

2. **Lokaler Test:**
   - Versuche lokal ein Archive zu erstellen: **Product → Archive**
   - Versuche lokal zu exportieren: **Distribute App → App Store Connect**
   - Falls das lokal funktioniert, ist es definitiv ein Xcode Cloud-spezifisches Problem

## Zusätzliche Ressourcen

- [Apple Developer Forums - Exit Code 70](https://developer.apple.com/forums/tag/xcode-cloud)
- [Xcode Cloud Troubleshooting](https://developer.apple.com/documentation/xcode/troubleshooting-xcode-cloud-builds)
- [Code Signing Best Practices](https://developer.apple.com/documentation/xcode/managing-your-team-s-signing-assets)

## Aktuelle Projekt-Konfiguration

**Bundle Identifiers:**
- Haupt-App: `com.documentdiary.app`
- Extension: `com.documentdiary.app.OneSignalNotificationServiceExtension`

**Development Team:**
- Beide Targets: `S3C3K89KGM`

**Code Signing:**
- Stil: Automatic
- Provisioning Profile: Automatic (leer = automatisch)

