const MessageGroup = @import("message_group.zig").MessageGroup;

/// Specifies a list of message groups that Amazon Lex uses to respond the
/// user input.
pub const ResponseSpecification = struct {
    /// Indicates whether the user can interrupt a speech response from
    /// Amazon Lex.
    allow_interrupt: ?bool,

    /// A collection of responses that Amazon Lex can send to the user. Amazon Lex
    /// chooses the actual response to send at runtime.
    message_groups: []const MessageGroup,

    pub const json_field_names = .{
        .allow_interrupt = "allowInterrupt",
        .message_groups = "messageGroups",
    };
};
