
# React Native User Agent

## Platforms Supported

- [x] iOS
- [x] Android

## Getting Started Guide

1. Add react-native-user-agent to your dependencies

```sh
yarn add react-native-user-agent
```

or, for npm use

```sh
npm install react-native-user-agent --save
```

2. Link native dependencies

2.1 **react-native >= 0.60**

Autolinking will take care of the link step, but for iOS, don't forget to run `pod install` in `ios/` folder

If you haven't set up cocoapods yet, please refer to [that article](https://engineering.brigad.co/demystifying-react-native-modules-linking-ae6c017a6b4a)

2.2 **react-native < 0.60**

You have to call `link` command manualy:

```sh
react-native link react-native-user-agent
```

*For manual linking*, please refer to:
- [that article](https://engineering.brigad.co/demystifying-react-native-modules-linking-964399ec731b) for Android
- [react-native own tutorial](https://facebook.github.io/react-native/docs/linking-libraries-ios) for iOS

## Usage

```javascript
import UserAgent from 'react-native-user-agent';

UserAgent.getUserAgent(); //synchronous

UserAgent.getWebViewUserAgent() //asynchronous
    .then(ua => {})
    .catch(e => {})
```

### Examples:

| System | User-Agent | WebView User-Agent |
| ------ | ---------- | ------------------ |
| iOS    | application-name/1.6.4.176 CFNetwork/897.15 Darwin/17.5.0 (iPhone/6s iOS/11.3) | Mozilla/5.0 (iPhone; CPU iPhone OS 11_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E217 |
| Android | application-name/1.6.7.42 Dalvik/2.1.0 (Linux; U; Android 5.1.1; Android SDK built for x86 Build/LMY48X) | Mozilla/5.0 (Linux; Android 5.1.1; Android SDK built for x86 Build/LMY48X) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/39.0.0.0 Mobile Safari/537.36 |

Additionally module returns a set of constants, that are used in user agent string building.

For iOS:
- systemName
- systemVersion
- applicationName
- applicationVersion
- buildNumber
- darwinVersion
- cfnetworkVersion
- deviceName **deprecated**
- modelName

For Android:
- systemName
- systemVersion
- applicatioName
- applicationVersion
- buildNumber

## Versioning

**Breaking History:**

- [2.0.0](https://github.com/bebnev/react-native-user-agent/releases/tag/v2.0.0) - supports [autolinking](https://github.com/react-native-community/cli/blob/master/docs/autolinking.md), native code refactoring, removes UIWebView, `getWebViewUserAgent()` returns promise
- [1.0.6](https://github.com/bebnev/react-native-user-agent/releases/tag/v1.0.6) - First release

## License

[MIT](LICENSE). Copyright (c) 2018 Anton Bebnev.
