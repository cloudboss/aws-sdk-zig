/// The templated target type for the Amazon SQS [
/// `SendMessage`
/// ](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_SendMessage.html) API operation.
/// Contains the message group ID to use when the target is a FIFO queue. If you
/// specify an Amazon SQS FIFO queue as a target, the queue must have
/// content-based deduplication enabled.
/// For more information, see [Using the Amazon SQS message deduplication
/// ID](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/using-messagededuplicationid-property.html) in the
/// *Amazon SQS Developer Guide*.
pub const SqsParameters = struct {
    /// The FIFO message group ID to use as the target.
    message_group_id: ?[]const u8,

    pub const json_field_names = .{
        .message_group_id = "MessageGroupId",
    };
};
