const aws = @import("aws");

const ChannelSubtype = @import("channel_subtype.zig").ChannelSubtype;
const MessageTemplateSourceConfiguration = @import("message_template_source_configuration.zig").MessageTemplateSourceConfiguration;

/// The summary of the message template.
pub const MessageTemplateSummary = struct {
    /// The version number of the message template version that is activated.
    active_version_number: ?i64 = null,

    /// The channel this message template applies to.
    channel: ?[]const u8 = null,

    /// The channel subtype this message template applies to.
    channel_subtype: ChannelSubtype,

    /// The timestamp when the message template was created.
    created_time: i64,

    /// The description of the message template.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the knowledge base.
    knowledge_base_arn: []const u8,

    /// The identifier of the knowledge base.
    knowledge_base_id: []const u8,

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

    source_configuration: ?MessageTemplateSourceConfiguration = null,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .active_version_number = "activeVersionNumber",
        .channel = "channel",
        .channel_subtype = "channelSubtype",
        .created_time = "createdTime",
        .description = "description",
        .knowledge_base_arn = "knowledgeBaseArn",
        .knowledge_base_id = "knowledgeBaseId",
        .last_modified_by = "lastModifiedBy",
        .last_modified_time = "lastModifiedTime",
        .message_template_arn = "messageTemplateArn",
        .message_template_id = "messageTemplateId",
        .name = "name",
        .source_configuration = "sourceConfiguration",
        .tags = "tags",
    };
};
