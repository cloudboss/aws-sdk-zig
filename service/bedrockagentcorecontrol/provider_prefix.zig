/// The configuration that controls how a provider prefix is applied to model
/// IDs during translation.
pub const ProviderPrefix = struct {
    /// The single character that separates the provider prefix from the model name
    /// (for example, `.`). The default is `.`.
    separator: []const u8 = ".",

    /// Whether clients can omit the provider prefix from model IDs. If `true`, the
    /// gateway accepts model IDs without the prefix and restores the full prefixed
    /// form before forwarding to the provider. The default is `false`.
    strip: bool = false,

    pub const json_field_names = .{
        .separator = "separator",
        .strip = "strip",
    };
};
