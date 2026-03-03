const aws = @import("aws");

const MessageHeader = @import("message_header.zig").MessageHeader;

/// Specifies the content and settings for a message template that can be used
/// in messages that are sent through the email channel.
pub const EmailTemplateRequest = struct {
    /// A JSON object that specifies the default values to use for message variables
    /// in the message template. This object is a set of key-value pairs. Each key
    /// defines a message variable in the template. The corresponding value defines
    /// the default value for that variable. When you create a message that's based
    /// on the template, you can override these defaults with message-specific and
    /// address-specific variables and values.
    default_substitutions: ?[]const u8 = null,

    /// The list of
    /// [MessageHeaders](https://docs.aws.amazon.com/pinpoint/latest/apireference/templates-template-name-email.html#templates-template-name-email-model-messageheader) for the email. You can have up to 15 Headers.
    headers: ?[]const MessageHeader = null,

    /// The message body, in HTML format, to use in email messages that are based on
    /// the message template. We recommend using HTML format for email clients that
    /// render HTML content. You can include links, formatted text, and more in an
    /// HTML message.
    html_part: ?[]const u8 = null,

    /// The unique identifier for the recommender model to use for the message
    /// template. Amazon Pinpoint uses this value to determine how to retrieve and
    /// process data from a recommender model when it sends messages that use the
    /// template, if the template contains message variables for recommendation
    /// data.
    recommender_id: ?[]const u8 = null,

    /// The subject line, or title, to use in email messages that are based on the
    /// message template.
    subject: ?[]const u8 = null,

    /// As of **22-05-2023** tags has been deprecated for update operations. After
    /// this date any value in tags is not processed and an error code is not
    /// returned. To manage tags we recommend using either
    /// [Tags](https://docs.aws.amazon.com/pinpoint/latest/apireference/tags-resource-arn.html) in the *API Reference for Amazon Pinpoint*, [resourcegroupstaggingapi](https://docs.aws.amazon.com/cli/latest/reference/resourcegroupstaggingapi/index.html) commands in the *AWS Command Line Interface Documentation* or [resourcegroupstaggingapi](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/resourcegroupstaggingapi/package-summary.html) in the *AWS SDK*.
    ///
    /// (Deprecated) A string-to-string map of key-value pairs that defines the tags
    /// to associate with the message template. Each tag consists of a required tag
    /// key and an associated tag value.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// A custom description of the message template.
    template_description: ?[]const u8 = null,

    /// The message body, in plain text format, to use in email messages that are
    /// based on the message template. We recommend using plain text format for
    /// email clients that don't render HTML content and clients that are connected
    /// to high-latency networks, such as mobile devices.
    text_part: ?[]const u8 = null,

    pub const json_field_names = .{
        .default_substitutions = "DefaultSubstitutions",
        .headers = "Headers",
        .html_part = "HtmlPart",
        .recommender_id = "RecommenderId",
        .subject = "Subject",
        .tags = "tags",
        .template_description = "TemplateDescription",
        .text_part = "TextPart",
    };
};
