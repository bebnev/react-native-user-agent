
import { NativeModules } from 'react-native';

const { RNUserAgent } = NativeModules;

module.exports = {
  ...RNUserAgent,
  getUserAgent() {
    return RNUserAgent.userAgent;
  },
  getWebViewUserAgent() {
    return RNUserAgent.webViewUserAgent;
  },
};

