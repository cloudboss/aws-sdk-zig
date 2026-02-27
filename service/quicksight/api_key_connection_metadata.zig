/// Configuration for API key-based authentication to external services.
pub const APIKeyConnectionMetadata = struct {
    /// The API key used for authentication.
    api_key: []const u8,

    /// The base URL endpoint for the external service.
    base_endpoint: []const u8,

    /// The email address associated with the API key, if required.
    email: ?[]const u8,

    pub const json_field_names = .{
        .api_key = "ApiKey",
        .base_endpoint = "BaseEndpoint",
        .email = "Email",
    };
};
