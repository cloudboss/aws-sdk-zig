const aws = @import("aws");

const MessageTemplateAttachment = @import("message_template_attachment.zig").MessageTemplateAttachment;
const MessageTemplateAttributeType = @import("message_template_attribute_type.zig").MessageTemplateAttributeType;
const ChannelSubtype = @import("channel_subtype.zig").ChannelSubtype;
const MessageTemplateContentProvider = @import("message_template_content_provider.zig").MessageTemplateContentProvider;
const MessageTemplateAttributes = @import("message_template_attributes.zig").MessageTemplateAttributes;
const GroupingConfiguration = @import("grouping_configuration.zig").GroupingConfiguration;
const MessageTemplateSourceConfigurationSummary = @import("message_template_source_configuration_summary.zig").MessageTemplateSourceConfigurationSummary;

/// The extended data of a message template.
pub const ExtendedMessageTemplateData = struct {
    /// The message template attachments.
    attachments: ?[]const MessageTemplateAttachment = null,

    /// The types of attributes contain the message template.
    attribute_types: ?[]const MessageTemplateAttributeType = null,

    /// The channel of the message template.
    channel: ?[]const u8 = null,

    /// The channel subtype this message template applies to.
    channel_subtype: ChannelSubtype,

    /// The content of the message template.
    content: ?MessageTemplateContentProvider = null,

    /// The timestamp when the message template was created.
    created_time: i64,

    /// An object that specifies the default values to use for variables in the
    /// message template. This object contains different categories of key-value
    /// pairs. Each key defines a variable or placeholder in the message template.
    /// The corresponding value defines the default value for that variable.
    default_attributes: ?MessageTemplateAttributes = null,

    /// The description of the message template.
    description: ?[]const u8 = null,

    grouping_configuration: ?GroupingConfiguration = null,

    /// Whether the version of the message template is activated.
    is_active: ?bool = null,

    /// The Amazon Resource Name (ARN) of the knowledge base.
    knowledge_base_arn: []const u8,

    /// The identifier of the knowledge base.
    knowledge_base_id: []const u8,

    /// The language code value for the language in which the quick response is
    /// written. The supported language codes include `de_DE`, `en_US`, `es_ES`,
    /// `fr_FR`, `id_ID`, `it_IT`, `ja_JP`, `ko_KR`, `pt_BR`, `zh_CN`, `zh_TW`
    language: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the user who last updated the message
    /// template data.
    last_modified_by: []const u8,

    /// The timestamp when the message template data was last modified.
    last_modified_time: i64,

    /// The Amazon Resource Name (ARN) of the message template.
    message_template_arn: []const u8,

    /// The checksum value of the message template content that is referenced by the
    /// `$LATEST` qualifier. It can be returned in `MessageTemplateData` or
    /// `ExtendedMessageTemplateData`. It’s calculated by content, language,
    /// `defaultAttributes` and `Attachments` of the message template.
    message_template_content_sha_256: []const u8,

    /// The identifier of the message template.
    message_template_id: []const u8,

    /// The name of the message template.
    name: []const u8,

    /// The source configuration summary of the message template.
    source_configuration_summary: ?MessageTemplateSourceConfigurationSummary = null,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The version number of the message template version.
    version_number: ?i64 = null,

    pub const json_field_names = .{
        .attachments = "attachments",
        .attribute_types = "attributeTypes",
        .channel = "channel",
        .channel_subtype = "channelSubtype",
        .content = "content",
        .created_time = "createdTime",
        .default_attributes = "defaultAttributes",
        .description = "description",
        .grouping_configuration = "groupingConfiguration",
        .is_active = "isActive",
        .knowledge_base_arn = "knowledgeBaseArn",
        .knowledge_base_id = "knowledgeBaseId",
        .language = "language",
        .last_modified_by = "lastModifiedBy",
        .last_modified_time = "lastModifiedTime",
        .message_template_arn = "messageTemplateArn",
        .message_template_content_sha_256 = "messageTemplateContentSha256",
        .message_template_id = "messageTemplateId",
        .name = "name",
        .source_configuration_summary = "sourceConfigurationSummary",
        .tags = "tags",
        .version_number = "versionNumber",
    };
};
