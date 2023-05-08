import * as React from 'react';

import { StyleSheet, Text, View } from 'react-native';
import {
  initZettle,
  say,
  showSettingsView,
  charge,
} from 'react-native-verzettled';
import Config from './config.json';

export default function App() {
  return (
    <View style={styles.container}>
      <Text
        style={styles.button}
        onPress={async () => {
          const result = await say(Config.clientId);
          console.log(result);
        }}
      >
        say
      </Text>
      <Text
        style={styles.button}
        onPress={async () => {
          try {
            const result = await initZettle(
              Config.clientId,
              Config.callbackURL
            );
            console.log(result);
          } catch (error) {
            console.log(error);
            console.log(JSON.stringify(error));
          }
        }}
      >
        init
      </Text>
      <Text
        style={styles.button}
        onPress={async () => {
          const result = await showSettingsView();
          console.log(result);
        }}
      >
        showSettingsView
      </Text>
      <Text
        style={styles.button}
        onPress={async () => {
          const result = await charge(5);
          console.log(result);
        }}
      >
        charge
      </Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: 'white',
  },
  button: {
    marginVertical: 20,
  },
});
