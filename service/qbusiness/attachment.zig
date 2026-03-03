const CopyFromSource = @import("copy_from_source.zig").CopyFromSource;
const ErrorDetail = @import("error_detail.zig").ErrorDetail;
const AttachmentStatus = @import("attachment_status.zig").AttachmentStatus;

/// An attachment in an Amazon Q Business conversation.
pub const Attachment = struct {
    /// The identifier of the Amazon Q Business attachment.
    attachment_id: ?[]const u8 = null,

    /// The identifier of the Amazon Q Business conversation the attachment is
    /// associated with.
    conversation_id: ?[]const u8 = null,

    /// A CopyFromSource containing a reference to the original source of the Amazon
    /// Q Business attachment.
    copy_from: ?CopyFromSource = null,

    /// The Unix timestamp when the Amazon Q Business attachment was created.
    created_at: ?i64 = null,

    /// ErrorDetail providing information about a Amazon Q Business attachment
    /// error.
    @"error": ?ErrorDetail = null,

    /// Size in bytes of the Amazon Q Business attachment.
    file_size: ?i32 = null,

    /// Filetype of the Amazon Q Business attachment.
    file_type: ?[]const u8 = null,

    /// MD5 checksum of the Amazon Q Business attachment contents.
    md_5_chksum: ?[]const u8 = null,

    /// Filename of the Amazon Q Business attachment.
    name: ?[]const u8 = null,

    /// AttachmentStatus of the Amazon Q Business attachment.
    status: ?AttachmentStatus = null,

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
