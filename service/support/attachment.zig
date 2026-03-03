/// An attachment to a case communication. The attachment consists of the file
/// name and
/// the content of the file. Each attachment file size should not exceed 5 MB.
/// File types that are supported include the following: pdf, jpeg,.doc, .log,
/// .text
pub const Attachment = struct {
    /// The content of the attachment file.
    data: ?[]const u8 = null,

    /// The name of the attachment file.
    file_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .data = "data",
        .file_name = "fileName",
    };
};
