/// This structure includes the custom parameter to be used when the target is
/// an SQS FIFO
/// queue.
pub const SqsParameters = struct {
    /// The FIFO message group ID to use as the target.
    message_group_id: ?[]const u8,

    pub const json_field_names = .{
        .message_group_id = "MessageGroupId",
    };
};
