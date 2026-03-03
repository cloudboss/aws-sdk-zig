const SseConfig = @import("sse_config.zig").SseConfig;

/// Details about a reference store.
pub const ReferenceStoreDetail = struct {
    /// The store's ARN.
    arn: []const u8,

    /// When the store was created.
    creation_time: i64,

    /// The store's description.
    description: ?[]const u8 = null,

    /// The store's ID.
    id: []const u8,

    /// The store's name.
    name: ?[]const u8 = null,

    /// The store's server-side encryption (SSE) settings.
    sse_config: ?SseConfig = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .description = "description",
        .id = "id",
        .name = "name",
        .sse_config = "sseConfig",
    };
};
