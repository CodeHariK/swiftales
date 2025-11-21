import { useNavigation, StaticScreenProps, NavigationProp } from '@react-navigation/native';
import { View, TextInput } from 'react-native';
import { Button, Text } from '@react-navigation/elements';
import * as React from 'react';

type CreatePostScreenProps = StaticScreenProps<{}>;

export function CreatePost({ route }: CreatePostScreenProps) {
    const navigation = useNavigation<NavigationProp<any>>();

    const [postText, setPostText] = React.useState('');

    return (
        <View style={{ flex: 1, padding: 20 }}>
            <TextInput
                multiline
                placeholder="What's on your mind?"
                style={{ height: 200, padding: 10, backgroundColor: 'white', borderWidth: 1, borderColor: '#ccc', borderRadius: 8 }}
                value={postText}
                onChangeText={setPostText}
            />
            <Button
                onPress={() => {
                    // Navigate to HomeTabs with params for the Home screen
                    navigation.navigate('HomeTabs', {
                        screen: 'Home',
                        params: { post: postText },
                    });
                }}
            >
                Done
            </Button>
        </View>
    );
}

