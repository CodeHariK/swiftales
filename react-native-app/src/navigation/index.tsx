import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { HeaderButton, Text } from '@react-navigation/elements';
import {
  createStaticNavigation,
  StaticParamList,
} from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { Home } from './screens/Home';
import { Profile } from './screens/Profile';
import { Settings } from './screens/Settings';
import { Updates } from './screens/Updates';
import { NotFound } from './screens/NotFound';
import { Details } from './screens/Details';
import { CreatePost } from './screens/CreatePost';
import { Charts } from './screens/Charts';
import { Pager } from './screens/Pager';
import { ClashCards } from './screens/clash/ClashCards';
import { ClashInfo } from './screens/clash/ClashInfo';

import FontAwesome6 from '@expo/vector-icons/FontAwesome6';
import Feather from '@expo/vector-icons/Feather';

const HomeTabs = createBottomTabNavigator({
  screens: {
    Home: {
      screen: Home,
      options: {
        title: 'Feed',
        tabBarIcon: ({ color, size }) => (
          <FontAwesome6 name="newspaper" size={24} color={color} />
        ),
      },
    },
    Updates: {
      screen: Updates,
      options: {
        tabBarIcon: ({ color, size }) => (
          <Feather name="bell" size={24} color={color} />
        ),
      },
    },
  },
});

const ClashRoyaleCardsStack = createNativeStackNavigator({
  screens: {
    ClashCards: {
      screen: ClashCards,
      options: ({ navigation }) => ({
        title: 'Clash Royale Cards',
        headerLeft: () => {
          const parent = navigation.getParent();
          const canGoBack = parent?.canGoBack() ?? false;
          return canGoBack ? (
            <HeaderButton onPress={() => parent?.goBack()}>
              <Text>← Back</Text>
            </HeaderButton>
          ) : null;
        },
      }),
    },
    ClashInfo: {
      screen: ClashInfo,
      options: ({ route }) => ({
        title: (route.params as { cardName?: string })?.cardName || 'Card Info',
      }),
    },
  },
});

const RootStack = createNativeStackNavigator({
  // screenOptions: {
  //   headerStyle: {
  //     backgroundColor: '#f4511e',
  //   },
  //   headerTintColor: '#fff',
  //   headerTitleStyle: {
  //     fontWeight: 'bold',
  //   },
  // },
  screens: {
    HomeTabs: {
      screen: HomeTabs,
      options: {
        title: 'Home',
        headerShown: false,
      },
    },
    Profile: {
      screen: Profile,
      options: ({ route }) => ({
        title: "Hello " + JSON.stringify(route.params),
        headerStyle: {
          backgroundColor: '#c53698',
        },
        headerTintColor: '#fff',
        headerTitleStyle: {
          fontWeight: 'bold',
        },
      }),

      linking: {
        path: ':user(@[a-zA-Z0-9-_]+)',
        parse: {
          user: (value) => value.replace(/^@/, ''),
        },
        stringify: {
          user: (value) => `@${value}`,
        },
      },
    },
    Details: {
      screen: Details,
      options: {
      },
      linking: {
        path: 'details/:itemId?',
        parse: {
          itemId: (value) => (value ? parseInt(value, 10) : undefined),
        },
        stringify: {
          itemId: (value) => (value ? value.toString() : ''),
        },
      },
    },
    CreatePost: {
      screen: CreatePost,
      options: {
        title: 'Create Post',
      },
    },
    Settings: {
      screen: Settings,
      options: ({ navigation }) => ({
        presentation: 'modal',
        headerRight: () => (
          <HeaderButton onPress={navigation.goBack}>
            <Text>Close</Text>
          </HeaderButton>
        ),
      }),
    },
    Charts: {
      screen: Charts,
      options: {
        title: 'Charts',
      },
    },
    Pager: {
      screen: Pager,
      options: {
        title: 'Pager',
      },
    },
    ClashRoyaleCards: {
      screen: ClashRoyaleCardsStack,
      options: {
        headerShown: false, // Hide root header, let nested stack handle its own headers
      },
    },
    NotFound: {
      screen: NotFound,
      options: {
        title: '404',
      },
      linking: {
        path: '*',
      },
    },
  },
});

export const Navigation = createStaticNavigation(RootStack);

type RootStackParamList = StaticParamList<typeof RootStack>;

declare global {
  namespace ReactNavigation {
    interface RootParamList extends RootStackParamList { }
  }
}
