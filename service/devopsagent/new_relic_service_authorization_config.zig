const NewRelicApiKeyConfig = @import("new_relic_api_key_config.zig").NewRelicApiKeyConfig;

/// Authorization configuration options for New Relic service.
pub const NewRelicServiceAuthorizationConfig = union(enum) {
    /// New Relic API Key authentication (apiKey, accountId, region).
    api_key: ?NewRelicApiKeyConfig,

    pub const json_field_names = .{
        .api_key = "apiKey",
    };
};
