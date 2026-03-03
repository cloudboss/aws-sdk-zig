/// A conversation in an Amazon Q Business application.
pub const Conversation = struct {
    /// The identifier of the Amazon Q Business conversation.
    conversation_id: ?[]const u8 = null,

    /// The start time of the conversation.
    start_time: ?i64 = null,

    /// The title of the conversation.
    title: ?[]const u8 = null,

    pub const json_field_names = .{
        .conversation_id = "conversationId",
        .start_time = "startTime",
        .title = "title",
    };
};
