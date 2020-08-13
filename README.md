# Metal Playground 

Simple setup to play around with Metal

## Build

### General
- `#> git submodule sync && git submodule update --init --recursive`

### iOS

- `#> mkdir xcode-build-ios && cd xcode-build-ios`
- `#> cmake .. -G Xcode -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_SYSROOT=iphoneos -DCMAKE_OSX_ARCHITECTURES=arm64`
- `#> open Metal\ Playground.xcodeproj/`
- Setup signing and run `ios-glfm-app` target