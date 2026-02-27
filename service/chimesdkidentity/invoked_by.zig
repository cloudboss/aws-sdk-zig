const StandardMessages = @import("standard_messages.zig").StandardMessages;
const TargetedMessages = @import("targeted_messages.zig").TargetedMessages;

/// Specifies the type of message that triggers a bot.
pub const InvokedBy = struct {
    /// Sets standard messages as the bot trigger. For standard messages:
    ///
    /// * `ALL`: The bot processes all standard messages.
    ///
    /// * `AUTO`: The bot responds to ALL messages when the channel has one other
    ///   non-hidden member, and responds to MENTIONS when the
    /// channel has more than one other non-hidden member.
    ///
    /// * `MENTIONS`: The bot processes all standard messages that have a message
    ///   attribute with `CHIME.mentions` and a
    /// value of the bot ARN.
    ///
    /// * `NONE`: The bot processes no standard messages.
    standard_messages: StandardMessages,

    /// Sets targeted messages as the bot trigger. For targeted messages:
    ///
    /// * `ALL`: The bot processes all `TargetedMessages` sent to it. The bot then
    ///   responds with a targeted message back to the sender.
    ///
    /// * `NONE`: The bot processes no targeted messages.
    targeted_messages: TargetedMessages,

    pub const json_field_names = .{
        .standard_messages = "StandardMessages",
        .targeted_messages = "TargetedMessages",
    };
};
