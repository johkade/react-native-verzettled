import React, { useState } from 'react'

import { StyleSheet, ScrollView, Text } from 'react-native'
import * as Zettle from 'react-native-verzettled'
import { Button } from './button'
import Config from './config.json'

export default function App() {
  const [wasInitialized, setWasInitialized] = useState(false)

  return (
    <ScrollView style={styles.container} contentContainerStyle={styles.content}>
      <Text style={styles.heading}>react-native-verzettled</Text>
      <Button
        label={wasInitialized ? '☑ initialized' : 'initialize'}
        successful={wasInitialized}
        onPress={async () => {
          try {
            const result = await Zettle.initZettle(
              Config.clientId,
              Config.callbackURL
            )
            if (result === 'Success') {
              setWasInitialized(true)
            }
            console.log(result)
          } catch (error) {
            console.log(error)
            console.log(JSON.stringify(error))
          }
        }}
      />

      <Button
        label="showSettingsView"
        onPress={async () => {
          try {
            const result = await Zettle.showSettingsView()
            console.log(result)
          } catch (error) {
            console.log(error)
            console.log(JSON.stringify(error))
          }
        }}
      />

      <Button
        label="charge"
        onPress={async () => {
          try {
            const result = await Zettle.charge(5)
            console.log(result)
          } catch (error) {
            console.log(error)
            console.log(JSON.stringify(error))
          }
        }}
      />
    </ScrollView>
  )
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#0a2743',
  },
  content: {
    minHeight: '100%',
    alignItems: 'center',
    justifyContent: 'center',
  },
  heading: {
    fontSize: 32,
    color: 'white',
    textAlign: 'center',
    marginBottom: 64,
    fontWeight: '200',
  },
})
