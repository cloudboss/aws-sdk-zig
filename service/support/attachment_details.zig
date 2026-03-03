/// The file name and ID of an attachment to a case communication. You can use
/// the ID to
/// retrieve the attachment with the DescribeAttachment operation.
pub const AttachmentDetails = struct {
    /// The ID of the attachment.
    attachment_id: ?[]const u8 = null,

    /// The file name of the attachment.
    file_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .attachment_id = "attachmentId",
        .file_name = "fileName",
    };
};
