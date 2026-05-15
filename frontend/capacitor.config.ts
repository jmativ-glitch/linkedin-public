import { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId:   'com.hrlinkedin.pro',
  appName: 'HR LinkedIn Pro',
  webDir:  'dist',

  server: {
    // En desarrollo: apunta al backend local
    // En producción: usa los archivos locales (eliminar esta línea)
    // url: 'https://tu-app.railway.app',
    androidScheme: 'https',
    cleartext:     false,
  },

  android: {
    buildOptions: {
      // Para generar APK firmado (opcional)
      // keystorePath:  'keystore/hr-linkedin.jks',
      // keystoreAlias: 'hr-linkedin',
    },
    minSdkVersion: 22,
    targetSdkVersion: 34,
    backgroundColor: '#050c18',
  },

  plugins: {
    SplashScreen: {
      launchShowDuration: 2000,
      backgroundColor:    '#050c18',
      showSpinner:        true,
      spinnerColor:       '#0a7bc4',
    },
    StatusBar: {
      style:           'Dark',
      backgroundColor: '#050c18',
    },
  },
};

export default config;
