/// Authentication metadata for connections that do not require authentication
/// credentials.
pub const NoneConnectionMetadata = struct {
    /// The base endpoint URL for connections that do not require authentication.
    base_endpoint: []const u8,

    pub const json_field_names = .{
        .base_endpoint = "BaseEndpoint",
    };
};
