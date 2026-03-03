/// The parameters for using a Amazon SQS stream as a target.
pub const PipeTargetSqsQueueParameters = struct {
    /// This parameter applies only to FIFO (first-in-first-out) queues.
    ///
    /// The token used for deduplication of sent messages.
    message_deduplication_id: ?[]const u8 = null,

    /// The FIFO message group ID to use as the target.
    message_group_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .message_deduplication_id = "MessageDeduplicationId",
        .message_group_id = "MessageGroupId",
    };
};
