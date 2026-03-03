const MessageGroup = @import("message_group.zig").MessageGroup;

/// Provides settings for a message that is sent to the user when a
/// fulfillment Lambda function starts running.
pub const FulfillmentStartResponseSpecification = struct {
    /// Determines whether the user can interrupt the start message while it
    /// is playing.
    allow_interrupt: ?bool = null,

    /// The delay between when the Lambda fulfillment function starts running
    /// and the start message is played. If the Lambda function returns before
    /// the delay is over, the start message isn't played.
    delay_in_seconds: i32,

    /// 1 - 5 message groups that contain start messages. Amazon Lex chooses
    /// one of the messages to play to the user.
    message_groups: []const MessageGroup,

    pub const json_field_names = .{
        .allow_interrupt = "allowInterrupt",
        .delay_in_seconds = "delayInSeconds",
        .message_groups = "messageGroups",
    };
};
