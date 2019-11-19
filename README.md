<p align="center"><img src="https://avatars3.githubusercontent.com/u/45311177?s=200&v=4"></p>

<p align="center">
<a href="https://travis-ci.org/nuxed/asset"><img src="https://travis-ci.org/nuxed/asset.svg" alt="Build Status"></a>
<a href="https://packagist.org/packages/nuxed/asset"><img src="https://poser.pugx.org/nuxed/asset/d/total.svg" alt="Total Downloads"></a>
<a href="https://packagist.org/packages/nuxed/asset"><img src="https://poser.pugx.org/nuxed/asset/v/stable.svg" alt="Latest Stable Version"></a>
<a href="https://packagist.org/packages/nuxed/asset"><img src="https://poser.pugx.org/nuxed/asset/license.svg" alt="License"></a>
</p>

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

  $package = new Asset\UrlPackage($cdns, $version);

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
