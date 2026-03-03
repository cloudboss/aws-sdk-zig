const ETagAlgorithmFamily = @import("e_tag_algorithm_family.zig").ETagAlgorithmFamily;
const SseConfig = @import("sse_config.zig").SseConfig;
const SequenceStoreStatus = @import("sequence_store_status.zig").SequenceStoreStatus;

/// Details about a sequence store.
pub const SequenceStoreDetail = struct {
    /// The store's ARN.
    arn: []const u8,

    /// When the store was created.
    creation_time: i64,

    /// The store's description.
    description: ?[]const u8 = null,

    /// The algorithm family of the ETag.
    e_tag_algorithm_family: ?ETagAlgorithmFamily = null,

    /// An S3 location that is used to store files that have failed a direct upload.
    fallback_location: ?[]const u8 = null,

    /// The store's ID.
    id: []const u8,

    /// The store's name.
    name: ?[]const u8 = null,

    /// The store's server-side encryption (SSE) settings.
    sse_config: ?SseConfig = null,

    /// Status of the sequence store.
    status: ?SequenceStoreStatus = null,

    /// The status message of the sequence store.
    status_message: ?[]const u8 = null,

    /// The last-updated time of the Sequence Store.
    update_time: ?i64 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .description = "description",
        .e_tag_algorithm_family = "eTagAlgorithmFamily",
        .fallback_location = "fallbackLocation",
        .id = "id",
        .name = "name",
        .sse_config = "sseConfig",
        .status = "status",
        .status_message = "statusMessage",
        .update_time = "updateTime",
    };
};
