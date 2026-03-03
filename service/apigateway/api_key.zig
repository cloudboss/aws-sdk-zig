const aws = @import("aws");

/// A resource that can be distributed to callers for executing Method resources
/// that require an API key. API keys can be mapped to any Stage on any RestApi,
/// which indicates that the callers with the API key can make requests to that
/// stage.
pub const ApiKey = struct {
    /// The timestamp when the API Key was created.
    created_date: ?i64 = null,

    /// An Amazon Web Services Marketplace customer identifier, when integrating
    /// with the Amazon Web Services SaaS Marketplace.
    customer_id: ?[]const u8 = null,

    /// The description of the API Key.
    description: ?[]const u8 = null,

    /// Specifies whether the API Key can be used by callers.
    enabled: bool = false,

    /// The identifier of the API Key.
    id: ?[]const u8 = null,

    /// The timestamp when the API Key was last updated.
    last_updated_date: ?i64 = null,

    /// The name of the API Key.
    name: ?[]const u8 = null,

    /// A list of Stage resources that are associated with the ApiKey resource.
    stage_keys: ?[]const []const u8 = null,

    /// The collection of tags. Each tag element is associated with a given
    /// resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The value of the API Key.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_date = "createdDate",
        .customer_id = "customerId",
        .description = "description",
        .enabled = "enabled",
        .id = "id",
        .last_updated_date = "lastUpdatedDate",
        .name = "name",
        .stage_keys = "stageKeys",
        .tags = "tags",
        .value = "value",
    };
};
