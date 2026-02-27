const ConversationMessage = @import("conversation_message.zig").ConversationMessage;

/// The input options for generating an Q App definition.
pub const PredictQAppInputOptions = union(enum) {
    /// A conversation to use as input for generating the Q App definition.
    conversation: ?[]const ConversationMessage,
    /// A problem statement to use as input for generating the Q App definition.
    problem_statement: ?[]const u8,

    pub const json_field_names = .{
        .conversation = "conversation",
        .problem_statement = "problemStatement",
    };
};
