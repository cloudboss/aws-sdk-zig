/// Read-only authentication metadata for API key-based connections, containing
/// non-sensitive configuration details.
pub const ReadAPIKeyConnectionMetadata = struct {
    /// The base endpoint URL for API key authentication.
    base_endpoint: []const u8,

    /// The email address associated with the API key authentication.
    email: ?[]const u8 = null,

    pub const json_field_names = .{
        .base_endpoint = "BaseEndpoint",
        .email = "Email",
    };
};
