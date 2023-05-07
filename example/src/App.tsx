import * as React from 'react';

import { StyleSheet, Text, View } from 'react-native';
import { initZettle, say, showSettingsView } from 'react-native-verzettled';

export default function App() {
  return (
    <View style={styles.container}>
      <Text
        style={{ marginBottom: 50 }}
        onPress={async () => {
          const result = await say('99999999-9999-9999-9999-999999999999');
          console.log(result);
        }}
      >
        say
      </Text>
      <Text
        style={{ marginBottom: 50 }}
        onPress={async () => {
          try {
            const result = await initZettle(
              '2328be19-2f9a-481f-a26e-34a879f9b8d1', //5
              'zettledemo://zettlecallback'
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
        style={{ marginBottom: 50 }}
        onPress={async () => {
          const result = await showSettingsView('');
          console.log(result);
        }}
      >
        showSettingsView
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
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
