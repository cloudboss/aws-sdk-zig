/// Contains information about a queue resource for which metrics are returned.
pub const QueueReference = struct {
    /// The Amazon Resource Name (ARN) of the queue.
    arn: ?[]const u8,

    /// The identifier of the queue.
    id: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
    };
};
