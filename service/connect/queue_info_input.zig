/// Information about a queue.
pub const QueueInfoInput = struct {
    /// The identifier of the queue.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "Id",
    };
};
