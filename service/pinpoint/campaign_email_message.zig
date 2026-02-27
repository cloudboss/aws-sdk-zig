const MessageHeader = @import("message_header.zig").MessageHeader;

/// Specifies the content and "From" address for an email message that's sent to
/// recipients of a campaign.
pub const CampaignEmailMessage = struct {
    /// The body of the email for recipients whose email clients don't render HTML
    /// content.
    body: ?[]const u8,

    /// The verified email address to send the email from. The default address is
    /// the FromAddress specified for the email channel for the application.
    from_address: ?[]const u8,

    /// The list of
    /// [MessageHeaders](https://docs.aws.amazon.com/pinpoint/latest/apireference/apps-application-id-campaigns-campaign-id.html#apps-application-id-campaigns-campaign-id-model-messageheader) for the email. You can have up to 15 MessageHeaders for each email.
    headers: ?[]const MessageHeader,

    /// The body of the email, in HTML format, for recipients whose email clients
    /// render HTML content.
    html_body: ?[]const u8,

    /// The subject line, or title, of the email.
    title: ?[]const u8,

    pub const json_field_names = .{
        .body = "Body",
        .from_address = "FromAddress",
        .headers = "Headers",
        .html_body = "HtmlBody",
        .title = "Title",
    };
};
