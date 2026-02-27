/// The connector-specific profile credentials required when using Trend Micro.
pub const TrendmicroConnectorProfileCredentials = struct {
    /// The Secret Access Key portion of the credentials.
    api_secret_key: []const u8,

    pub const json_field_names = .{
        .api_secret_key = "apiSecretKey",
    };
};
