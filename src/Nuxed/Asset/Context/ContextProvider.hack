namespace Nuxed\Asset\Context;

final class ContextProvider implements IContextProvider {
    private function __construct(private IContext $context) {}

    public static function create(
        string $base_path,
        bool $secure,
    ): ContextProvider {
        return new ContextProvider(Context::create($base_path, $secure));
    }

    public static function forContext(IContext $context): ContextProvider {
        return new ContextProvider($context);
    }

    public function getContext(): IContext {
        return $this->context;
    }
}
