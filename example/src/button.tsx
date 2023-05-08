import React from 'react'
import {
  ActivityIndicator,
  StyleSheet,
  Text,
  TouchableOpacity,
} from 'react-native'

export interface ButtonProps {
  label: string
  onPress?: () => void
  disabled?: boolean
  isLoading?: boolean
  successful?: boolean
}

export const Button = ({
  label,
  onPress,
  disabled,
  successful,
  isLoading,
}: ButtonProps) => {
  return (
    <TouchableOpacity
      activeOpacity={0.8}
      style={[
        styles.container,
        disabled && { opacity: 0.3 },
        successful && styles.successful,
      ]}
      disabled={disabled}
      onPress={onPress}
    >
      <Text style={styles.label}>{label}</Text>
      {isLoading && <ActivityIndicator style={styles.spinner} />}
    </TouchableOpacity>
  )
}

const styles = StyleSheet.create({
  container: {
    borderRadius: 12,
    paddingHorizontal: 24,
    paddingVertical: 12,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#48a8e4',
    marginVertical: 20,
    flexDirection: 'row',
    shadowColor: '#222',
    shadowOpacity: 0.8,
    shadowRadius: 16,
  },
  successful: {
    backgroundColor: '#4bdd72',
  },
  label: { color: '#2b2b2b', fontSize: 20 },
  spinner: { marginLeft: 16 },
})
