/// The template for email messages that threat protection sends to a user when
/// your
/// threat protection automated response has a *Notify* action.
pub const NotifyEmailType = struct {
    /// The body of an email notification formatted in HTML. Choose an `HtmlBody`
    /// or a `TextBody` to send an HTML-formatted or plaintext message,
    /// respectively.
    html_body: ?[]const u8,

    /// The subject of the threat protection email notification.
    subject: []const u8,

    /// The body of an email notification formatted in plaintext. Choose an
    /// `HtmlBody` or a `TextBody` to send an HTML-formatted or
    /// plaintext message, respectively.
    text_body: ?[]const u8,

    pub const json_field_names = .{
        .html_body = "HtmlBody",
        .subject = "Subject",
        .text_body = "TextBody",
    };
};
