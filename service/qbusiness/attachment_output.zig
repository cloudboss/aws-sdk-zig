const ErrorDetail = @import("error_detail.zig").ErrorDetail;
const AttachmentStatus = @import("attachment_status.zig").AttachmentStatus;

/// The details of a file uploaded during chat.
pub const AttachmentOutput = struct {
    /// The unique identifier of the Amazon Q Business attachment.
    attachment_id: ?[]const u8,

    /// The unique identifier of the Amazon Q Business conversation.
    conversation_id: ?[]const u8,

    /// An error associated with a file uploaded during chat.
    @"error": ?ErrorDetail,

    /// The name of a file uploaded during chat.
    name: ?[]const u8,

    /// The status of a file uploaded during chat.
    status: ?AttachmentStatus,

    pub const json_field_names = .{
        .attachment_id = "attachmentId",
        .conversation_id = "conversationId",
        .@"error" = "error",
        .name = "name",
        .status = "status",
    };
};
