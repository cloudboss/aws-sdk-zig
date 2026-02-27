/// The current browser signing configuration that shows whether cryptographic
/// agent identification is enabled for web bot authentication.
pub const BrowserSigningConfigOutput = struct {
    /// Indicates whether browser signing is currently enabled for cryptographic
    /// agent identification using HTTP message signatures.
    enabled: bool = false,

    pub const json_field_names = .{
        .enabled = "enabled",
    };
};
