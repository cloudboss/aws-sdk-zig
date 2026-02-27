/// An object representing a change in state for a task attachment.
pub const AttachmentStateChange = struct {
    /// The Amazon Resource Name (ARN) of the attachment.
    attachment_arn: []const u8,

    /// The status of the attachment.
    status: []const u8,

    pub const json_field_names = .{
        .attachment_arn = "attachmentArn",
        .status = "status",
    };
};
