import { DarkTheme, DefaultTheme, Theme } from '@react-navigation/native';
import React, { createContext, useContext, useState, useEffect } from 'react';
import { useColorScheme, Appearance } from 'react-native';

type ThemeMode = 'light' | 'dark' | 'auto';

interface ThemeContextType {
    theme: Theme;
    themeMode: ThemeMode;
    setThemeMode: (mode: ThemeMode) => void;
    isDark: boolean;
}

const ThemeContext = createContext<ThemeContextType | undefined>(undefined);

export function ThemeProvider({ children }: { children: React.ReactNode }) {
    const systemColorScheme = useColorScheme();
    const [themeMode, setThemeMode] = useState<ThemeMode>('auto');
    const [isDark, setIsDark] = useState(systemColorScheme === 'dark');

    useEffect(() => {
        if (themeMode === 'auto') {
            setIsDark(systemColorScheme === 'dark');
        } else {
            setIsDark(themeMode === 'dark');
        }
    }, [themeMode, systemColorScheme]);

    // Sync with native appearance
    useEffect(() => {
        if (themeMode === 'auto') {
            const subscription = Appearance.addChangeListener(({ colorScheme }) => {
                setIsDark(colorScheme === 'dark');
            });
            return () => subscription.remove();
        }
    }, [themeMode]);

    const theme = isDark ? DarkTheme : DefaultTheme;

    return (
        <ThemeContext.Provider value={{ theme, themeMode, setThemeMode, isDark }}>
            {children}
        </ThemeContext.Provider>
    );
}

export function useAppTheme() {
    const context = useContext(ThemeContext);
    if (context === undefined) {
        throw new Error('useAppTheme must be used within a ThemeProvider');
    }
    return context;
}

