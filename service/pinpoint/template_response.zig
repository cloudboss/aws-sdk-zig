const aws = @import("aws");

const TemplateType = @import("template_type.zig").TemplateType;

/// Provides information about a message template that's associated with your
/// Amazon Pinpoint account.
pub const TemplateResponse = struct {
    /// The Amazon Resource Name (ARN) of the message template. This value isn't
    /// included in a TemplateResponse object. To retrieve the ARN of a template,
    /// use the GetEmailTemplate, GetPushTemplate, GetSmsTemplate, or
    /// GetVoiceTemplate operation, depending on the type of template that you want
    /// to retrieve the ARN for.
    arn: ?[]const u8 = null,

    /// The date, in ISO 8601 format, when the message template was created.
    creation_date: []const u8,

    /// The JSON object that specifies the default values that are used for message
    /// variables in the message template. This object isn't included in a
    /// TemplateResponse object. To retrieve this object for a template, use the
    /// GetEmailTemplate, GetPushTemplate, GetSmsTemplate, or GetVoiceTemplate
    /// operation, depending on the type of template that you want to retrieve the
    /// object for.
    default_substitutions: ?[]const u8 = null,

    /// The date, in ISO 8601 format, when the message template was last modified.
    last_modified_date: []const u8,

    /// A map of key-value pairs that identifies the tags that are associated with
    /// the message template. This object isn't included in a TemplateResponse
    /// object. To retrieve this object for a template, use the GetEmailTemplate,
    /// GetPushTemplate, GetSmsTemplate, or GetVoiceTemplate operation, depending on
    /// the type of template that you want to retrieve the object for.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The custom description of the message template. This value isn't included in
    /// a TemplateResponse object. To retrieve the description of a template, use
    /// the GetEmailTemplate, GetPushTemplate, GetSmsTemplate, or GetVoiceTemplate
    /// operation, depending on the type of template that you want to retrieve the
    /// description for.
    template_description: ?[]const u8 = null,

    /// The name of the message template.
    template_name: []const u8,

    /// The type of channel that the message template is designed for. Possible
    /// values are: EMAIL, PUSH, SMS, INAPP, and VOICE.
    template_type: TemplateType,

    /// The unique identifier, as an integer, for the active version of the message
    /// template.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_date = "CreationDate",
        .default_substitutions = "DefaultSubstitutions",
        .last_modified_date = "LastModifiedDate",
        .tags = "tags",
        .template_description = "TemplateDescription",
        .template_name = "TemplateName",
        .template_type = "TemplateType",
        .version = "Version",
    };
};
