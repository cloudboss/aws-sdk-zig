const aws = @import("aws");

const TemplateType = @import("template_type.zig").TemplateType;

/// Provides information about the content and settings for a message template
/// that can be used in text messages that are sent through the SMS channel.
pub const SMSTemplateResponse = struct {
    /// The Amazon Resource Name (ARN) of the message template.
    arn: ?[]const u8,

    /// The message body that's used in text messages that are based on the message
    /// template.
    body: ?[]const u8,

    /// The date, in ISO 8601 format, when the message template was created.
    creation_date: []const u8,

    /// The JSON object that specifies the default values that are used for message
    /// variables in the message template. This object is a set of key-value pairs.
    /// Each key defines a message variable in the template. The corresponding value
    /// defines the default value for that variable.
    default_substitutions: ?[]const u8,

    /// The date, in ISO 8601 format, when the message template was last modified.
    last_modified_date: []const u8,

    /// The unique identifier for the recommender model that's used by the message
    /// template.
    recommender_id: ?[]const u8,

    /// A string-to-string map of key-value pairs that identifies the tags that are
    /// associated with the message template. Each tag consists of a required tag
    /// key and an associated tag value.
    tags: ?[]const aws.map.StringMapEntry,

    /// The custom description of the message template.
    template_description: ?[]const u8,

    /// The name of the message template.
    template_name: []const u8,

    /// The type of channel that the message template is designed for. For an SMS
    /// template, this value is SMS.
    template_type: TemplateType,

    /// The unique identifier, as an integer, for the active version of the message
    /// template, or the version of the template that you specified by using the
    /// version parameter in your request.
    version: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .body = "Body",
        .creation_date = "CreationDate",
        .default_substitutions = "DefaultSubstitutions",
        .last_modified_date = "LastModifiedDate",
        .recommender_id = "RecommenderId",
        .tags = "tags",
        .template_description = "TemplateDescription",
        .template_name = "TemplateName",
        .template_type = "TemplateType",
        .version = "Version",
    };
};
