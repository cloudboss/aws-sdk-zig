/// An attribute of an attachment, such as the attachment name.
pub const AttachmentInformation = struct {
    /// The name of the attachment.
    name: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
