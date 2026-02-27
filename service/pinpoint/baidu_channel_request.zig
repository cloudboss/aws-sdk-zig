/// Specifies the status and settings of the Baidu (Baidu Cloud Push) channel
/// for an application.
pub const BaiduChannelRequest = struct {
    /// The API key that you received from the Baidu Cloud Push service to
    /// communicate with the service.
    api_key: []const u8,

    /// Specifies whether to enable the Baidu channel for the application.
    enabled: ?bool,

    /// The secret key that you received from the Baidu Cloud Push service to
    /// communicate with the service.
    secret_key: []const u8,

    pub const json_field_names = .{
        .api_key = "ApiKey",
        .enabled = "Enabled",
        .secret_key = "SecretKey",
    };
};
