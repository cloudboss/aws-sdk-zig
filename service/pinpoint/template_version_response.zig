/// Provides information about a specific version of a message template.
pub const TemplateVersionResponse = struct {
    /// The date, in ISO 8601 format, when the version of the message template was
    /// created.
    creation_date: []const u8,

    /// A JSON object that specifies the default values that are used for message
    /// variables in the version of the message template. This object is a set of
    /// key-value pairs. Each key defines a message variable in the template. The
    /// corresponding value defines the default value for that variable.
    default_substitutions: ?[]const u8 = null,

    /// The date, in ISO 8601 format, when the version of the message template was
    /// last modified.
    last_modified_date: []const u8,

    /// The custom description of the version of the message template.
    template_description: ?[]const u8 = null,

    /// The name of the message template.
    template_name: []const u8,

    /// The type of channel that the message template is designed for. Possible
    /// values are: EMAIL, PUSH, SMS, INAPP, and VOICE.
    template_type: []const u8,

    /// The unique identifier for the version of the message template. This value is
    /// an integer that Amazon Pinpoint automatically increments and assigns to each
    /// new version of a template.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_date = "CreationDate",
        .default_substitutions = "DefaultSubstitutions",
        .last_modified_date = "LastModifiedDate",
        .template_description = "TemplateDescription",
        .template_name = "TemplateName",
        .template_type = "TemplateType",
        .version = "Version",
    };
};
