const MessageGroup = @import("message_group.zig").MessageGroup;

/// Provides settings for a message that is sent periodically to the
/// user while a fulfillment Lambda function is running.
pub const FulfillmentUpdateResponseSpecification = struct {
    /// Determines whether the user can interrupt an update message while it
    /// is playing.
    allow_interrupt: ?bool = null,

    /// The frequency that a message is sent to the user. When the period
    /// ends, Amazon Lex chooses a message from the message groups and plays it to
    /// the user. If the fulfillment Lambda returns before the first period
    /// ends, an update message is not played to the user.
    frequency_in_seconds: i32,

    /// 1 - 5 message groups that contain update messages. Amazon Lex chooses
    /// one of the messages to play to the user.
    message_groups: []const MessageGroup,

    pub const json_field_names = .{
        .allow_interrupt = "allowInterrupt",
        .frequency_in_seconds = "frequencyInSeconds",
        .message_groups = "messageGroups",
    };
};
