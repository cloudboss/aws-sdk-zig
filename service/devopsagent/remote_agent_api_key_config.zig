/// API key configuration for remote A2A agent.
pub const RemoteAgentAPIKeyConfig = struct {
    /// HTTP header name to send the API key in requests to the service.
    api_key_header: []const u8,

    /// User friendly API key name specified by end user.
    api_key_name: []const u8,

    /// API key value for authenticating with the service.
    api_key_value: []const u8,

    pub const json_field_names = .{
        .api_key_header = "apiKeyHeader",
        .api_key_name = "apiKeyName",
        .api_key_value = "apiKeyValue",
    };
};
