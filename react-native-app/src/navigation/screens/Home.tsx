import { Button, Text } from '@react-navigation/elements';
import { StyleSheet, View } from 'react-native';
import { useNavigation, StaticScreenProps } from '@react-navigation/native';
import * as React from 'react';
import { Button as RNButton } from 'react-native'
import { RoutePathHeader } from '../../components/RoutePathHeader';

type HomeScreenProps = StaticScreenProps<{
  post?: string;
}>;

export function Home({ route }: HomeScreenProps) {
  const navigation = useNavigation<any>();

  // Use an effect to monitor the update to params
  React.useEffect(() => {
    if (route.params?.post) {
      // Post updated, do something with `route.params.post`
      // For example, send the post to the server
      if (route.params?.post !== null) {
        alert('New post: ' + route.params?.post);
      }
    }
  }, [route.params?.post]);

  return (
    <View style={styles.container}>
      <RoutePathHeader />
      <Button screen="Profile" params={{ user: 'jane' }}>
        Go to Profile
      </Button>
      <Button screen="Settings">Go to Settings</Button>

      <RNButton
        title="Go to Create Post"
        onPress={() => {
          return navigation.navigate('CreatePost');
        }} />

      <Text>Post: {route.params?.post}</Text>

      <RNButton
        title="Go to Profile"
        onPress={() => {
          return navigation.navigate(
            'Profile',
            { user: 'jane' });
        }} />

      <Button
        onPress={() => {
          /* 1. Navigate to the Details route with params */
          navigation.navigate('Details', {
            itemId: 86,
            otherParam: 'anything you want here',
          });
        }}
      >
        Go to Details
      </Button>

      <Button
        onPress={() => {
          return navigation.setParams({ post: null });
        }}
      >
        Clear Post
      </Button>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    gap: 10,
  },
});
