# iTunes Rating Bar

## Description

Very simple itunes rating menu bar app for macOS 

## Usage

import into XCode and compile

### Changing itunes bridge

The sbhc.py script leverages the Python bindings for libclang. You must install these bindings before running the script. You'll also need to install the Xcode command line tools. 

Install python 'clang' module.

```bash
$sudo easy_install clang
```

Now, you can generate itunes swift bridge 

```bash
./createItunesBridge.sh
```

Special thank's to [Tony Ingraldi](https://github.com/tingraldi/SwiftScripting) for python scripts and samples

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/rvillamil/iTunesQuickRatingBar/tags).

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
