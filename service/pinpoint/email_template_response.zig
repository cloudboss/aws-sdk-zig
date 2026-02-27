const aws = @import("aws");

const MessageHeader = @import("message_header.zig").MessageHeader;
const TemplateType = @import("template_type.zig").TemplateType;

/// Provides information about the content and settings for a message template
/// that can be used in messages that are sent through the email channel.
pub const EmailTemplateResponse = struct {
    /// The Amazon Resource Name (ARN) of the message template.
    arn: ?[]const u8,

    /// The date, in ISO 8601 format, when the message template was created.
    creation_date: []const u8,

    /// The JSON object that specifies the default values that are used for message
    /// variables in the message template. This object is a set of key-value pairs.
    /// Each key defines a message variable in the template. The corresponding value
    /// defines the default value for that variable.
    default_substitutions: ?[]const u8,

    /// The list of
    /// [MessageHeaders](https://docs.aws.amazon.com/pinpoint/latest/apireference/templates-template-name-email.html#templates-template-name-email-model-messageheader) for the email. You can have up to 15 Headers.
    headers: ?[]const MessageHeader,

    /// The message body, in HTML format, that's used in email messages that are
    /// based on the message template.
    html_part: ?[]const u8,

    /// The date, in ISO 8601 format, when the message template was last modified.
    last_modified_date: []const u8,

    /// The unique identifier for the recommender model that's used by the message
    /// template.
    recommender_id: ?[]const u8,

    /// The subject line, or title, that's used in email messages that are based on
    /// the message template.
    subject: ?[]const u8,

    /// A string-to-string map of key-value pairs that identifies the tags that are
    /// associated with the message template. Each tag consists of a required tag
    /// key and an associated tag value.
    tags: ?[]const aws.map.StringMapEntry,

    /// The custom description of the message template.
    template_description: ?[]const u8,

    /// The name of the message template.
    template_name: []const u8,

    /// The type of channel that the message template is designed for. For an email
    /// template, this value is EMAIL.
    template_type: TemplateType,

    /// The message body, in plain text format, that's used in email messages that
    /// are based on the message template.
    text_part: ?[]const u8,

    /// The unique identifier, as an integer, for the active version of the message
    /// template, or the version of the template that you specified by using the
    /// version parameter in your request.
    version: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_date = "CreationDate",
        .default_substitutions = "DefaultSubstitutions",
        .headers = "Headers",
        .html_part = "HtmlPart",
        .last_modified_date = "LastModifiedDate",
        .recommender_id = "RecommenderId",
        .subject = "Subject",
        .tags = "tags",
        .template_description = "TemplateDescription",
        .template_name = "TemplateName",
        .template_type = "TemplateType",
        .text_part = "TextPart",
        .version = "Version",
    };
};
