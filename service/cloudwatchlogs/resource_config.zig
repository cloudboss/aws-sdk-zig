const OpenSearchResourceConfig = @import("open_search_resource_config.zig").OpenSearchResourceConfig;

/// This structure contains configuration details about an integration between
/// CloudWatch Logs and another entity.
pub const ResourceConfig = union(enum) {
    /// This structure contains configuration details about an integration between
    /// CloudWatch Logs and OpenSearch Service.
    open_search_resource_config: ?OpenSearchResourceConfig,

    pub const json_field_names = .{
        .open_search_resource_config = "openSearchResourceConfig",
    };
};
