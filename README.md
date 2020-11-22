<p align="center"><img src="https://avatars3.githubusercontent.com/u/45311177?s=200&v=4"></p>

![Coding standards status](https://github.com/nuxed/asset/workflows/coding%20standards/badge.svg?branch=develop)
![Static analysis status](https://github.com/nuxed/asset/workflows/static%20analysis/badge.svg?branch=develop)
![Unit tests status](https://github.com/nuxed/asset/workflows/unit%20tests/badge.svg?branch=develop)
[![Total Downloads](https://poser.pugx.org/nuxed/asset/d/total.svg)](https://packagist.org/packages/nuxed/asset)
[![Latest Stable Version](https://poser.pugx.org/nuxed/asset/v/stable.svg)](https://packagist.org/packages/nuxed/asset)
[![License](https://poser.pugx.org/nuxed/asset/license.svg)](https://packagist.org/packages/nuxed/asset)


# Nuxed Asset

The Nuxed Asset component manages URL generation and versioning of web assets such as CSS stylesheets, JavaScript files and image files. 

### Installation

This package can be installed with [Composer](https://getcomposer.org).

```console
$ composer require nuxed/asset
```

### Example

```hack
use namespace Nuxed\Asset;
use namespace Nuxed\Asset\VersionStrategy;

<<__EntryPoint>>
async function main(): Awaitable<void> {
  // For example, the manifest file might look like this:
  // {
  //   "main.js": "main.abc123.js",
  //   "css/styles.css": "css/styles.555abc.css"
  // }
  $versionStrategy = new VersionStrategy\JsonManifestVersionStrategy('/path/to/manifest.json');

  $cdns = vec[
    'https://asset-s1.example.com/',
    'https://asset-s2.example.com/',
  ];

  $package = new Asset\UrlPackage($cdns, $versionStrategy);

  // https://asset-s2.example.com/css/styles.555abc.css
  echo await $package->getUrl('css/styles.css');
}
```

---

### Security

For information on reporting security vulnerabilities in Nuxed, see [SECURITY.md](SECURITY.md).

---

### License

Nuxed is open-sourced software licensed under the MIT-licensed.
