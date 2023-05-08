# react-native-verzettled

Wrapper module for iZettleSDK for iOS and Android. (WIP)

> 💡 **_NOTE:_** Android is currently unsupported and will be added later, iOS is WIP.
> 💡 **_NOTE:_** Currently there's no support for expo / eas, as there'S no config plugin yet.

## Installation

```sh
npm install react-native-verzettled
cd ios && pod install
```

## Setup

Reports -> ähnlich wie bei Stripe (report types) -> CRUD stack

#### iOS Deployment target

Set your iOS Deployment Target to >13.0 in XCode

#### Info.plist

Add the following to your Info.plist.

```xml
<key>NSBluetoothAlwaysUsageDescription</key>
<string>Our app uses bluetooth to find, connect and transfer data with Zettle card reader devices.</string>

<key>NSBluetoothPeripheralUsageDescription</key>
<string>Our app uses bluetooth to find, connect and transfer data with Zettle card reader devices.</string>

<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>myAppScheme</string>
        </array>
    </dict>
</array>
<key>UISupportedExternalAccessoryProtocols</key>
 <array>
     <string>com.izettle.cardreader-one</string>
 </array>
 <key>NSLocationWhenInUseUsageDescription</key>
<string>You need to allow this to be able to accept card payments</string>
```

#### Add Background capabilities:

Select the following background modes to enable support for external accessory communication. You can find them in XCode under Signing & Capabilities in your target.

External accessory communication
Uses Bluetooth LE accessory

## Usage

Check out the example project.

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
