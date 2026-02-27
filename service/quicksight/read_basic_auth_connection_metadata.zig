/// Read-only metadata for basic authentication connections, containing
/// non-sensitive configuration details.
pub const ReadBasicAuthConnectionMetadata = struct {
    /// The base endpoint URL for basic authentication.
    base_endpoint: []const u8,

    /// The username used for basic authentication.
    username: []const u8,

    pub const json_field_names = .{
        .base_endpoint = "BaseEndpoint",
        .username = "Username",
    };
};
