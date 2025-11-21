import { Assets as NavigationAssets } from '@react-navigation/elements';
import { Asset } from 'expo-asset';
import { createURL } from 'expo-linking';
import * as SplashScreen from 'expo-splash-screen';
import * as React from 'react';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { Navigation } from './navigation';
import { ThemeProvider, useAppTheme } from './contexts/ThemeContext';

import { GluestackUIProvider } from '@/components/ui/gluestack-ui-provider';
import '@/global.css';

const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      retry: 2,
      refetchOnWindowFocus: false,
    },
  },
});

Asset.loadAsync([
  ...NavigationAssets,
  // require('./assets/newspaper.png'),
]);

SplashScreen.preventAutoHideAsync();

const prefix = createURL('/');

function NavigationWrapper() {
  const { theme } = useAppTheme();

  return (

    <GluestackUIProvider mode={theme.dark ? 'dark' : 'light'}>
      <Navigation
        theme={theme}
        linking={{
          enabled: 'auto',
          prefixes: [prefix],
        }}
        onReady={() => {
          SplashScreen.hideAsync(
          );
        }}
      />
    </GluestackUIProvider>
  );
}

export function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <ThemeProvider>
        <NavigationWrapper />
      </ThemeProvider>
    </QueryClientProvider>
  );
}
