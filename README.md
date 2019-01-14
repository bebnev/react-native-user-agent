
# react-native-user-agent

## Getting started

Install with [npm](https://www.npmjs.com/) or [Yarn](https://yarnpkg.com/):

npm:
```sh
npm install react-native-user-agent --save
```

Yarn:
```sh
yarn add react-native-user-agent
```

### Mostly automatic installation

`$ react-native link react-native-user-agent`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-user-agent` and add `RNUserAgent.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNUserAgent.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainApplication.java`
  - Add `import com.bebnev.RNUserAgentPackage;` to the imports at the top of the file
  - Add `new RNUserAgentPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-user-agent'
  	project(':react-native-user-agent').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-user-agent/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-user-agent')
  	```

## Usage

```javascript
import UserAgent from 'react-native-user-agent';

UserAgent.getUserAgent();
UserAgent.getWebViewUserAgent();
```

### Examples:

| System | User-Agent | WebView User-Agent |
| ------ | ---------- | ------------------ |
| iOS    | application-name/1.6.4.176 CFNetwork/897.15 Darwin/17.5.0 (iPhone/6s iOS/11.3) | Mozilla/5.0 (iPhone; CPU iPhone OS 11_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E217 |
| Android | application-name/1.6.7.42 Dalvik/2.1.0 (Linux; U; Android 5.1.1; Android SDK built for x86 Build/LMY48X) | Mozilla/5.0 (Linux; Android 5.1.1; Android SDK built for x86 Build/LMY48X) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/39.0.0.0 Mobile Safari/537.36 |

### Additionally:

Every version returns some constants that are used in user agent string building.

iOS version returns:
- systemName
- systemVersion
- applicationName
- applicationVersion
- applicationBuildNumber
- darwinVersion
- cfnetworkVersion
- deviceName

Android version returns:
- systemName
- systemVersion
- applicatioName
- applicationVersion
- applicationBuildNumber


## License

[MIT](LICENSE). Copyright (c) 2018 Anton Bebnev.
