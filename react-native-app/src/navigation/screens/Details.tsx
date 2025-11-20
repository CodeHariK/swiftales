import { useNavigation, StaticScreenProps } from "@react-navigation/native";
import { View } from 'react-native';
import { Button, Text } from '@react-navigation/elements';

type DetailsScreenProps = StaticScreenProps<{
    itemId?: number;
    otherParam?: string;
}>;

export function Details({ route }: DetailsScreenProps) {
    const navigation = useNavigation<any>();

    /* 2. Get the param */
    const { itemId, otherParam } = route.params;

    return (
        <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
            <Text>Details Screen</Text>
            <Text>itemId: {JSON.stringify(itemId)}</Text>
            <Text>otherParam: {JSON.stringify(otherParam)}</Text>
            <Button
                onPress={
                    () =>
                        navigation.push('Details', {
                            // Randomly generate an ID for demonstration purposes
                            itemId: Math.floor(Math.random() * 100),
                        })
                }
            >
                Go to Details... again
            </Button>
            <Button onPress={() => navigation.navigate('HomeTabs')}>Go to Home</Button>
            <Button onPress={() => navigation.goBack()}>Go back</Button>
        </View>
    );
}