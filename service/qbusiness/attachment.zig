const CopyFromSource = @import("copy_from_source.zig").CopyFromSource;
const ErrorDetail = @import("error_detail.zig").ErrorDetail;
const AttachmentStatus = @import("attachment_status.zig").AttachmentStatus;

/// An attachment in an Amazon Q Business conversation.
pub const Attachment = struct {
    /// The identifier of the Amazon Q Business attachment.
    attachment_id: ?[]const u8,

    /// The identifier of the Amazon Q Business conversation the attachment is
    /// associated with.
    conversation_id: ?[]const u8,

    /// A CopyFromSource containing a reference to the original source of the Amazon
    /// Q Business attachment.
    copy_from: ?CopyFromSource,

    /// The Unix timestamp when the Amazon Q Business attachment was created.
    created_at: ?i64,

    /// ErrorDetail providing information about a Amazon Q Business attachment
    /// error.
    @"error": ?ErrorDetail,

    /// Size in bytes of the Amazon Q Business attachment.
    file_size: ?i32,

    /// Filetype of the Amazon Q Business attachment.
    file_type: ?[]const u8,

    /// MD5 checksum of the Amazon Q Business attachment contents.
    md_5_chksum: ?[]const u8,

    /// Filename of the Amazon Q Business attachment.
    name: ?[]const u8,

    /// AttachmentStatus of the Amazon Q Business attachment.
    status: ?AttachmentStatus,

    pub const json_field_names = .{
        .attachment_id = "attachmentId",
        .conversation_id = "conversationId",
        .copy_from = "copyFrom",
        .created_at = "createdAt",
        .@"error" = "error",
        .file_size = "fileSize",
        .file_type = "fileType",
        .md_5_chksum = "md5chksum",
        .name = "name",
        .status = "status",
    };
};
