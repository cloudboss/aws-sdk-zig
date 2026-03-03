const AttachmentOutput = @import("attachment_output.zig").AttachmentOutput;

/// A failed file upload during web experience chat.
pub const FailedAttachmentEvent = struct {
    attachment: ?AttachmentOutput = null,

    /// The identifier of the conversation associated with the failed file upload.
    conversation_id: ?[]const u8 = null,

    /// The identifier of the AI-generated message associated with the file upload.
    system_message_id: ?[]const u8 = null,

    /// The identifier of the end user chat message associated with the file upload.
    user_message_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .attachment = "attachment",
        .conversation_id = "conversationId",
        .system_message_id = "systemMessageId",
        .user_message_id = "userMessageId",
    };
};
