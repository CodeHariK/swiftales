import { Text, StyleSheet, View } from 'react-native';
import { useTheme } from '@react-navigation/native';
import { useNavigationState } from '@react-navigation/native';

export function RoutePathHeader() {
    const { colors } = useTheme();
    const route = useNavigationState((state) => {
        if (!state) return null;

        // Get the current route
        const currentRoute = state.routes[state.index];

        // Build the path
        const path = getRoutePath(state, currentRoute);
        return path;
    });

    if (!route) {
        return null;
    }

    return (
        <Text style={[styles.text, { color: colors.text }]} numberOfLines={1}>
            {route}
        </Text>
    );
}

function getRoutePath(state: any, route: any): string {
    let routeName = route.name;

    // Add params to the route name if they exist
    if (route.params && Object.keys(route.params).length > 0) {
        const paramsStr = Object.entries(route.params)
            .map(([key, value]) => {
                // Format the param value
                if (typeof value === 'string' || typeof value === 'number') {
                    return `${key}=${value}`;
                }
                return `${key}=${JSON.stringify(value)}`;
            })
            .join(', ');
        routeName = `${route.name}(${paramsStr})`;
    }

    const path = [routeName];

    // If this route has nested state, get its path too
    if (route.state) {
        const nestedRoute = route.state.routes[route.state.index];
        if (nestedRoute) {
            path.push(...getRoutePath(route.state, nestedRoute).split(' / '));
        }
    }

    return path.join(' / ');
}

const styles = StyleSheet.create({
    text: {
        fontSize: 16,
    },
});

