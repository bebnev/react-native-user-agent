export function getUserAgent(): string;
export function getWebViewUserAgent(): Promise<string>;

// Android + iOS
export const systemName: string;
export const systemVersion: string;
export const applicationName: string;
export const applicationVersion: string;
export const buildNumber: string;

// iOS only
export const darwinVersion: string|undefined;
export const cfnetworkVersion: string|undefined;
export const modelName: string|undefined;

/**
 * @deprecated
 */
export const deviceName: string|undefined;