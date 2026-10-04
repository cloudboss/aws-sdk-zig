/// The custom parameters for EventBridge to use for a target that is an Amazon
/// SQS fair or FIFO queue.
pub const SqsParameters = struct {
    /// The ID of the message group to use as the target.
    message_group_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .message_group_id = "MessageGroupId",
    };
};
