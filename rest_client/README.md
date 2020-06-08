# rest_client

A new Flutter web project.

## Getting Started

## Setup
``` zsh
$ flutter channel beta
$ flutter upgrade
$ flutter config --enable-web
```

## Multiple Environments
```
$ pub global activate fvm
$ fvm install <version>
<version> is replaced by stable or beta (web)

Update the Flutter SDK path to the fvm path {fvm-path}/versions/stable. You can only do this after running the project once
```

Once web is enabled, the flutter devices command outputs a Chrome device that opens the Chrome browser with your app running, and a Web Server that provides the URL serving the app.
```shell script
$ flutter devices
2 connected device:

Web Server • web-server • web-javascript • Flutter Tools
Chrome     • chrome     • web-javascript • Google Chrome 81.0.4044.129
```

## Run App

```shell script
$ flutter run -d chrome
```