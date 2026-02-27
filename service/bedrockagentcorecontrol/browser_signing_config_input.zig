/// Configuration for enabling browser signing capabilities that allow agents to
/// cryptographically identify themselves to websites using HTTP message
/// signatures.
pub const BrowserSigningConfigInput = struct {
    /// Specifies whether browser signing is enabled. When enabled, the browser will
    /// cryptographically sign HTTP requests to identify itself as an AI agent to
    /// bot control vendors.
    enabled: bool = false,

    pub const json_field_names = .{
        .enabled = "enabled",
    };
};
