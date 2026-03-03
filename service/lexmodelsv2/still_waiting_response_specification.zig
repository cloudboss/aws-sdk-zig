const MessageGroup = @import("message_group.zig").MessageGroup;

/// Defines the messages that Amazon Lex sends to a user to remind them that
/// the bot is waiting for a response.
pub const StillWaitingResponseSpecification = struct {
    /// Indicates that the user can interrupt the response by speaking while
    /// the message is being played.
    allow_interrupt: ?bool = null,

    /// How often a message should be sent to the user. Minimum of 1 second,
    /// maximum of 5 minutes.
    frequency_in_seconds: i32,

    /// One or more message groups, each containing one or more messages,
    /// that define the prompts that Amazon Lex sends to the user.
    message_groups: []const MessageGroup,

    /// If Amazon Lex waits longer than this length of time for a response, it
    /// will stop sending messages.
    timeout_in_seconds: i32,

    pub const json_field_names = .{
        .allow_interrupt = "allowInterrupt",
        .frequency_in_seconds = "frequencyInSeconds",
        .message_groups = "messageGroups",
        .timeout_in_seconds = "timeoutInSeconds",
    };
};
