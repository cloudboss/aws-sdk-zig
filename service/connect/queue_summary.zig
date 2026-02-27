const QueueType = @import("queue_type.zig").QueueType;

/// Contains summary information about a queue.
pub const QueueSummary = struct {
    /// The Amazon Resource Name (ARN) of the queue.
    arn: ?[]const u8,

    /// The identifier of the queue.
    id: ?[]const u8,

    /// The Amazon Web Services Region where this resource was last modified.
    last_modified_region: ?[]const u8,

    /// The timestamp when this resource was last modified.
    last_modified_time: ?i64,

    /// The name of the queue.
    name: ?[]const u8,

    /// The type of queue.
    queue_type: ?QueueType,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .queue_type = "QueueType",
    };
};
