const aws = @import("aws");

const ChannelSubtype = @import("channel_subtype.zig").ChannelSubtype;
const GroupingConfiguration = @import("grouping_configuration.zig").GroupingConfiguration;
const MessageTemplateSourceConfigurationSummary = @import("message_template_source_configuration_summary.zig").MessageTemplateSourceConfigurationSummary;

/// The result of message template search.
pub const MessageTemplateSearchResultData = struct {
    /// The channel of the message template.
    channel: ?[]const u8,

    /// The channel subtype this message template applies to.
    channel_subtype: ChannelSubtype,

    /// The timestamp when the message template was created.
    created_time: i64,

    /// The description of the message template.
    description: ?[]const u8,

    grouping_configuration: ?GroupingConfiguration,

    /// Whether the version of the message template is activated.
    is_active: ?bool,

    /// The Amazon Resource Name (ARN) of the knowledge base.
    knowledge_base_arn: []const u8,

    /// The identifier of the knowledge base.
    knowledge_base_id: []const u8,

    /// The language code value for the language in which the quick response is
    /// written. The supported language codes include `de_DE`, `en_US`, `es_ES`,
    /// `fr_FR`, `id_ID`, `it_IT`, `ja_JP`, `ko_KR`, `pt_BR`, `zh_CN`, `zh_TW`
    language: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the user who last updated the message
    /// template data.
    last_modified_by: []const u8,

    /// The timestamp when the message template data was last modified.
    last_modified_time: i64,

    /// The Amazon Resource Name (ARN) of the message template.
    message_template_arn: []const u8,

    /// The identifier of the message template.
    message_template_id: []const u8,

    /// The name of the message template.
    name: []const u8,

    /// The source configuration summary of the message template.
    source_configuration_summary: ?MessageTemplateSourceConfigurationSummary,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry,

    /// The version number of the message template version.
    version_number: ?i64,

    pub const json_field_names = .{
        .channel = "channel",
        .channel_subtype = "channelSubtype",
        .created_time = "createdTime",
        .description = "description",
        .grouping_configuration = "groupingConfiguration",
        .is_active = "isActive",
        .knowledge_base_arn = "knowledgeBaseArn",
        .knowledge_base_id = "knowledgeBaseId",
        .language = "language",
        .last_modified_by = "lastModifiedBy",
        .last_modified_time = "lastModifiedTime",
        .message_template_arn = "messageTemplateArn",
        .message_template_id = "messageTemplateId",
        .name = "name",
        .source_configuration_summary = "sourceConfigurationSummary",
        .tags = "tags",
        .version_number = "versionNumber",
    };
};
