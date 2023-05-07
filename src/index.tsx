import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-verzettled' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const Verzettled = NativeModules.Verzettled
  ? NativeModules.Verzettled
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

export function multiply(a: number, b: number): Promise<number> {
  return Verzettled.multiply(a, b);
}

export function say(s: string): Promise<string> {
  return Verzettled.say(s);
}
