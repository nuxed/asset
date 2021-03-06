namespace Nuxed\Asset;

use namespace HH\Lib\Str;
use type Nuxed\Asset\VersionStrategy\IVersionStrategy;

/**
 * Package that adds a base path to asset URLs in addition to a version.
 *
 * In addition to the provided base path, this package also automatically
 * prepends the current request base path if a Context is available to
 * allow a website to be hosted easily under any given path under the Web
 * Server root directory.
 */
final class PathPackage extends Package {
  private string $basePath;

  /**
   * @param string  $basePath The base path to be prepended to relative paths
   */
  public function __construct(
    string $basePath,
    IVersionStrategy $versionStrategy,
    ?Context\IContextProvider $contextProvider = null,
  ) {
    parent::__construct($versionStrategy, $contextProvider);

    if ('' === $basePath) {
      $this->basePath = '/';
    } else {
      if ('/' !== $basePath[0]) {
        $basePath = '/'.$basePath;
      }

      $this->basePath = Str\trim_right($basePath, '/').'/';
    }
  }

  /**
   * {@inheritdoc}
   */
  <<__Override>>
  public async function getUrl(string $path): Awaitable<string> {
    if ($this->isAbsoluteUrl($path)) {
      return $path;
    }

    $versionedPath = await $this->getVersionStrategy()->applyVersion($path);

    // if absolute or begins with /, we're done
    if (
      $this->isAbsoluteUrl($versionedPath) ||
      (!Str\is_empty($versionedPath) && Str\starts_with($versionedPath, '/'))
    ) {
      return $versionedPath;
    }

    return $this->getBasePath().Str\trim_left($versionedPath, '/');
  }

  /**
   * Returns the base path.
   *
   * @return string The base path
   */
  public function getBasePath(): string {
    return $this->getContext()->getBasePath().$this->basePath;
  }
}
