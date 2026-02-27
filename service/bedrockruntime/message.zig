const ContentBlock = @import("content_block.zig").ContentBlock;
const ConversationRole = @import("conversation_role.zig").ConversationRole;

/// A message input, or returned from, a call to
/// [Converse](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_Converse.html) or [ConverseStream](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_ConverseStream.html).
pub const Message = struct {
    /// The message content. Note the following restrictions:
    ///
    /// * You can include up to 20 images. Each image's size, height, and width must
    ///   be no more than 3.75 MB, 8000 px, and 8000 px, respectively.
    /// * You can include up to five documents. Each document's size must be no more
    ///   than 4.5 MB.
    /// * If you include a `ContentBlock` with a `document` field in the array, you
    ///   must also include a `ContentBlock` with a `text` field.
    /// * You can only include images and documents if the `role` is `user`.
    content: []const ContentBlock,

    /// The role that the message plays in the message.
    role: ConversationRole,

    pub const json_field_names = .{
        .content = "content",
        .role = "role",
    };
};
