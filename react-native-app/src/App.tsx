import { Assets as NavigationAssets } from '@react-navigation/elements';
import { Asset } from 'expo-asset';
import { createURL } from 'expo-linking';
import * as SplashScreen from 'expo-splash-screen';
import * as React from 'react';
import { Navigation } from './navigation';
import { ThemeProvider, useAppTheme } from './contexts/ThemeContext';

Asset.loadAsync([
  ...NavigationAssets,
  // require('./assets/newspaper.png'),
]);

SplashScreen.preventAutoHideAsync();

const prefix = createURL('/');

function NavigationWrapper() {
  const { theme } = useAppTheme();

  return (
    <Navigation
      theme={theme}
      linking={{
        enabled: 'auto',
        prefixes: [prefix],
      }}
      onReady={() => {
        SplashScreen.hideAsync();
      }}
    />
  );
}

export function App() {
  return (
    <ThemeProvider>
      <NavigationWrapper />
    </ThemeProvider>
  );
}
