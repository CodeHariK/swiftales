import { useTheme } from '@react-navigation/native';
import { TouchableOpacity, Text, StyleSheet, View } from 'react-native';
import { useAppTheme } from '../contexts/ThemeContext';

export function ThemeToggle() {
    const { colors } = useTheme();
    const { isDark, setThemeMode } = useAppTheme();

    const toggleTheme = () => {
        if (isDark) {
            setThemeMode('light');
        } else {
            setThemeMode('dark');
        }
    };

    return (
        <TouchableOpacity
            style={[styles.container, { backgroundColor: colors.card, borderColor: colors.border }]}
            onPress={toggleTheme}
        >
            <View style={styles.content}>
                <Text style={[styles.label, { color: colors.text }]}>Theme</Text>
                <View style={styles.toggleContainer}>
                    <Text style={[styles.icon, { color: colors.text }]}>
                        {isDark ? '🌙' : '☀️'}
                    </Text>
                    <Text style={[styles.value, { color: colors.text }]}>
                        {isDark ? 'Dark' : 'Light'}
                    </Text>
                </View>
            </View>
        </TouchableOpacity>
    );
}

const styles = StyleSheet.create({
    container: {
        padding: 16,
        borderRadius: 8,
        borderWidth: 1,
        marginVertical: 8,
    },
    content: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
    },
    label: {
        fontSize: 16,
        fontWeight: '500',
    },
    toggleContainer: {
        flexDirection: 'row',
        alignItems: 'center',
        gap: 8,
    },
    icon: {
        fontSize: 20,
    },
    value: {
        fontSize: 16,
    },
});

