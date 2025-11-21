import { Button, Text } from '@react-navigation/elements';
import { StyleSheet, View } from 'react-native';
import { useNavigation, StaticScreenProps, NavigationProp } from '@react-navigation/native';
import * as React from 'react';
import { Button as RNButton } from 'react-native'
import { RoutePathHeader } from '../../components/RoutePathHeader';

import { Menu, MenuItem, MenuItemLabel } from '@/components/ui/menu';
import { Button as GluestackButton, ButtonText } from '@/components/ui/button';
import {
  Icon,
  AddIcon,
  GlobeIcon,
  PlayIcon,
  SettingsIcon,
} from '@/components/ui/icon';

function Example() {
  return (
    <Menu
      placement="top"
      offset={5}
      disabledKeys={['Settings']}
      trigger={({ ...triggerProps }) => {
        return (
          <GluestackButton {...triggerProps}>
            <ButtonText>Menu</ButtonText>
          </GluestackButton>
        );
      }}
    >
      <MenuItem key="Add account" textValue="Add account">
        <Icon as={AddIcon} size="sm" className="mr-2" />
        <MenuItemLabel size="sm">Add account</MenuItemLabel>
      </MenuItem>
      <MenuItem key="Community" textValue="Community">
        <Icon as={GlobeIcon} size="sm" className="mr-2" />
        <MenuItemLabel size="sm">Community</MenuItemLabel>
      </MenuItem>
      <MenuItem key="Plugins" textValue="Plugins">
        <Icon as={PlayIcon} size="sm" className="mr-2" />
        <MenuItemLabel size="sm">Plugins</MenuItemLabel>
      </MenuItem>
      <MenuItem key="Settings" textValue="Settings">
        <Icon as={SettingsIcon} size="sm" className="mr-2" />
        <MenuItemLabel size="sm">Settings</MenuItemLabel>
      </MenuItem>
    </Menu>
  );
}


type HomeScreenProps = StaticScreenProps<{
  post?: string;
}>;

export function Home({ route }: HomeScreenProps) {
  const navigation = useNavigation<NavigationProp<any>>();

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
      <Button screen="Charts">Go to Charts</Button>
      <Button screen="Pager">Go to Pager</Button>
      <Button screen="ClashRoyaleCards">Clash Royale Cards</Button>

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

      <Example />
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
