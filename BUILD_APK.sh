#!/bin/bash
# ═══════════════════════════════════════════════════
#  HR LinkedIn Pro — Script de Build APK
#  Ejecutar en tu máquina local con Android Studio
#  o en GitHub Actions (automático)
# ═══════════════════════════════════════════════════
set -e

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

echo -e "${GREEN}╔══════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   HR LinkedIn Pro — APK Builder      ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════╝${NC}"

# Verificar prerequisitos
check_req() {
  command -v $1 &>/dev/null || { echo -e "${RED}✗ $1 no encontrado. Instalalo primero.${NC}"; exit 1; }
  echo -e "${GREEN}✓ $1 OK${NC}"
}

echo -e "\n${YELLOW}Verificando prerequisitos...${NC}"
check_req node; check_req npm; check_req java
[ -n "$ANDROID_HOME" ] || { echo -e "${RED}✗ ANDROID_HOME no configurado${NC}"; exit 1; }
echo -e "${GREEN}✓ Android SDK: $ANDROID_HOME${NC}"

# Build frontend
echo -e "\n${YELLOW}Buildeando frontend React...${NC}"
cd frontend
npm ci
npm run build
echo -e "${GREEN}✓ Frontend buildeado${NC}"

# Sync Capacitor
echo -e "\n${YELLOW}Sincronizando Capacitor...${NC}"
npx cap sync android
echo -e "${GREEN}✓ Assets sincronizados${NC}"

# Build APK
echo -e "\n${YELLOW}Compilando APK...${NC}"
cd android
chmod +x gradlew
./gradlew assembleDebug --no-daemon

APK_PATH="app/build/outputs/apk/debug/app-debug.apk"
if [ -f "$APK_PATH" ]; then
  cp "$APK_PATH" "../../HR-LinkedIn-Pro-v1.0-debug.apk"
  echo -e "\n${GREEN}╔══════════════════════════════════════╗${NC}"
  echo -e "${GREEN}║  ✅ APK generado exitosamente!        ║${NC}"
  echo -e "${GREEN}║  📱 HR-LinkedIn-Pro-v1.0-debug.apk   ║${NC}"
  echo -e "${GREEN}╚══════════════════════════════════════╝${NC}"
  echo -e "\nInstalá el APK en tu Android:"
  echo -e "  adb install HR-LinkedIn-Pro-v1.0-debug.apk"
  echo -e "  O copiá el archivo al celular y abrilo directamente\n"
else
  echo -e "${RED}✗ Error: APK no generado${NC}"
  exit 1
fi
