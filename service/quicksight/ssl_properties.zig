/// Secure Socket Layer (SSL) properties that apply when Quick Sight connects to
/// your
/// underlying data source.
pub const SslProperties = struct {
    /// A Boolean option to control whether SSL should be disabled.
    disable_ssl: bool = false,

    pub const json_field_names = .{
        .disable_ssl = "DisableSsl",
    };
};
