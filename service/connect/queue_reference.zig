/// Contains information about a queue resource for which metrics are returned.
pub const QueueReference = struct {
    /// The Amazon Resource Name (ARN) of the queue.
    arn: ?[]const u8 = null,

    /// The identifier of the queue.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
    };
};
