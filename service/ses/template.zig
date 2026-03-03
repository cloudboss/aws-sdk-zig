/// The content of the email, composed of a subject line and either an HTML part
/// or a
/// text-only part.
pub const Template = struct {
    /// The HTML body of the email.
    html_part: ?[]const u8 = null,

    /// The subject line of the email.
    subject_part: ?[]const u8 = null,

    /// The name of the template. You use this name when you send email using the
    /// `SendTemplatedEmail` or `SendBulkTemplatedEmail`
    /// operations.
    template_name: []const u8,

    /// The email body that is visible to recipients whose email clients do not
    /// display HTML
    /// content.
    text_part: ?[]const u8 = null,
};
