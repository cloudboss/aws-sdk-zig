/// The API key credentials required for API key authentication.
pub const ApiKeyCredentials = struct {
    /// The API key required for API key authentication.
    api_key: []const u8,

    /// The API secret key required for API key authentication.
    api_secret_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_key = "apiKey",
        .api_secret_key = "apiSecretKey",
    };
};
