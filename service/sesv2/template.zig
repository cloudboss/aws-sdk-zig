const Attachment = @import("attachment.zig").Attachment;
const MessageHeader = @import("message_header.zig").MessageHeader;
const EmailTemplateContent = @import("email_template_content.zig").EmailTemplateContent;

/// An object that defines the email template to use for an email message, and
/// the values
/// to use for any message variables in that template. An *email
/// template* is a type of message template that contains content that you
/// want to reuse in email messages that you send. You can specifiy the email
/// template by providing
/// the name or ARN of an *email template*
/// previously saved in your Amazon SES account or by providing the full
/// template content.
pub const Template = struct {
    /// The List of attachments to include in your email. All recipients will
    /// receive the same attachments.
    attachments: ?[]const Attachment = null,

    /// The list of message headers that will be added to the email message.
    headers: ?[]const MessageHeader = null,

    /// The Amazon Resource Name (ARN) of the template.
    template_arn: ?[]const u8 = null,

    /// The content of the template.
    ///
    /// Amazon SES supports only simple substitions when you send email using the
    /// `SendEmail` or `SendBulkEmail` operations and
    /// you provide the full template content in the request.
    template_content: ?EmailTemplateContent = null,

    /// An object that defines the values to use for message variables in the
    /// template. This
    /// object is a set of key-value pairs. Each key defines a message variable in
    /// the template.
    /// The corresponding value defines the value to use for that variable.
    template_data: ?[]const u8 = null,

    /// The name of the template. You will refer to this name when you send email
    /// using the
    /// `SendEmail` or `SendBulkEmail` operations.
    template_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .attachments = "Attachments",
        .headers = "Headers",
        .template_arn = "TemplateArn",
        .template_content = "TemplateContent",
        .template_data = "TemplateData",
        .template_name = "TemplateName",
    };
};
