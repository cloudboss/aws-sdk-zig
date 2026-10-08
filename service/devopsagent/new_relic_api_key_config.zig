const NewRelicRegion = @import("new_relic_region.zig").NewRelicRegion;

/// API key authentication configuration for New Relic service.
pub const NewRelicApiKeyConfig = struct {
    /// New Relic Account ID
    account_id: []const u8,

    /// List of alert policy IDs grouping related conditions
    alert_policy_ids: ?[]const []const u8 = null,

    /// New Relic User API Key
    api_key: []const u8,

    /// List of monitored APM application IDs in New Relic
    application_ids: ?[]const []const u8 = null,

    /// List of globally unique IDs for New Relic resources (apps, hosts, services)
    entity_guids: ?[]const []const u8 = null,

    /// New Relic region (US or EU)
    region: NewRelicRegion,

    pub const json_field_names = .{
        .account_id = "accountId",
        .alert_policy_ids = "alertPolicyIds",
        .api_key = "apiKey",
        .application_ids = "applicationIds",
        .entity_guids = "entityGuids",
        .region = "region",
    };
};
