/// The connector-specific credentials required when using Amplitude.
pub const AmplitudeConnectorProfileCredentials = struct {
    /// A unique alphanumeric identifier used to authenticate a user, developer, or
    /// calling
    /// program to your API.
    api_key: []const u8,

    /// The Secret Access Key portion of the credentials.
    secret_key: []const u8,

    pub const json_field_names = .{
        .api_key = "apiKey",
        .secret_key = "secretKey",
    };
};
