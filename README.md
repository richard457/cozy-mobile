# [Cozy](http://cozy.io) Mobile client

[![Build Status](https://travis-ci.org/cozy/cozy-mobile.svg)](https://travis-ci.org/cozy/cozy-mobile)
[![Dependency Status](https://www.versioneye.com/user/projects/56c35ee518b271003b392193/badge.svg)](https://www.versioneye.com/user/projects/56c35ee518b271003b392193)
[![Code Climate](https://codeclimate.com/github/cozy/cozy-mobile/badges/gpa.svg)](https://codeclimate.com/github/cozy/cozy-mobile)

This is the native mobile client for Cozy.

## Install

Get it from the [Google Play Store](https://play.google.com/store/apps/details?id=io.cozy.files_client),
or head over to the [Releases page](https://github.com/cozy/cozy-mobile/releases)
or compile it.

    Some Time we need To mention that there is a case we on testing on real device there can be this error
    ``Android Cannot access org.apache.http.client.HttpClient ``
    - And can be solved by adding this ``useLibrary 'org.apache.http.legacy'`` into gradle in android part
    git clone https://github.com/cozy/cozy-mobile
    cd cozy-mobile
    npm install -g coffee-script
    cake install

### Resource for cordova installation
- [ubuntu todolist](http://askubuntu.com/questions/318246/complete-installation-guide-for-android-sdk-adt-bundle-on-ubuntu)
- [cordova manual](https://cordova.apache.org/docs/en/latest/guide/platforms/android/index.html)
- Necessary path
```bash
export ANDROID_HOME="/path/to/android-sdk-linux"
export PATH="$PATH:$ANDROID_HOME/tools"
export PATH="$PATH:$ANDROID_HOME/build-tools/23.0.2"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
```

## Build with
```bash
.$ cd src
./src$ npm run build # build coffee into js in src
./src$ npm run buildapk # build the apk using cordova
./src$ npm run release # sign the apk, need ./keys
```

## Hack

Make your changes in src, use brunch to compile in wwww

    cd src
    npm run start

To run on device / emulator

    ./src/node_modules/.bin/cordova run android

To run in browser,
- start chrome with --disable-web-security --allow-file-access-from-files
- open www/index.html
- in browser's console run
```
window.isBrowserDebugging = true
document.dispatchEvent(new Event('deviceready'));
```

Expect all things related to binary, contact or calendar to fail in browser.

If you want to test on your Android device directly, please install the Android
SDK http://developer.android.com/sdk/index.html. Then enable USB debugging and
`cordova run android` will run the application within your phone instead of from
the emulator.

## Contribute with Transifex

Transifex can be used the same way as git. It can push or pull translations. The
config file in the .tx repository configure the way Transifex is working : it
will get the json files from the client/app/locales repository.
If you want to learn more about how to use this tool, I'll invite you to check
 [this](http://docs.transifex.com/introduction/) tutorial.

### import

    tx pull

### export

    tx push -s

## License

Cozy Mobile Client is developed by Cozy Cloud and distributed under the LGPL v3
license.

## What is Cozy?

![Cozy Logo](https://raw.github.com/cozy/cozy-setup/gh-pages/assets/images/happycloud.png)

[Cozy](http://cozy.io) is a platform that brings all your web services in the
same private space.  With it, your web apps and your devices can share data
easily, providing you
with a new experience. You can install Cozy on your own hardware where no one
profiles you.

## Community

You can reach the Cozy Community by:

* Chatting with us on IRC #cozycloud on irc.freenode.net
* Posting on our [Forum](https://forum.cozy.io/)
* Posting issues on the [Github repos](https://github.com/cozy/)
* Mentioning us on [Twitter](http://twitter.com/mycozycloud)
