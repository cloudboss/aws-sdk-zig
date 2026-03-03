/// The content of the email, composed of a subject line, an HTML part, and a
/// text-only
/// part.
pub const EmailTemplateContent = struct {
    /// The HTML body of the email.
    html: ?[]const u8 = null,

    /// The subject line of the email.
    subject: ?[]const u8 = null,

    /// The email body that will be visible to recipients whose email clients do not
    /// display
    /// HTML.
    text: ?[]const u8 = null,

    pub const json_field_names = .{
        .html = "Html",
        .subject = "Subject",
        .text = "Text",
    };
};
