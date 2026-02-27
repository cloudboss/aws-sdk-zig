/// Metadata for basic authentication using username and password.
pub const BasicAuthConnectionMetadata = struct {
    /// The base URL endpoint for the external service.
    base_endpoint: []const u8,

    /// The password for basic authentication.
    password: []const u8,

    /// The username for basic authentication.
    username: []const u8,

    pub const json_field_names = .{
        .base_endpoint = "BaseEndpoint",
        .password = "Password",
        .username = "Username",
    };
};
