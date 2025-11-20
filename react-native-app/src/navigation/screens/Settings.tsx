import { StyleSheet, View, Text } from 'react-native';
import { useTheme } from '@react-navigation/native';
import { ThemeToggle } from '../../components/ThemeToggle';

export function Settings() {
  const { colors } = useTheme();

  return (
    <View style={styles.container}>
      <Text style={[styles.title, { color: colors.text }]}>Settings</Text>
      <ThemeToggle />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 16,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 24,
  },
  row: {
    flexDirection: 'row',
    gap: 10,
  },
});
