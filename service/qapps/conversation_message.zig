const Sender = @import("sender.zig").Sender;

/// A message in a conversation, used as input for generating an Amazon Q App
/// definition.
pub const ConversationMessage = struct {
    /// The text content of the conversation message.
    body: []const u8,

    /// The type of the conversation message.
    @"type": Sender,

    pub const json_field_names = .{
        .body = "body",
        .@"type" = "type",
    };
};
