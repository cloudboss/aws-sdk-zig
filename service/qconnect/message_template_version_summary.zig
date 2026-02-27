const ChannelSubtype = @import("channel_subtype.zig").ChannelSubtype;

/// The summary of the message template version.
pub const MessageTemplateVersionSummary = struct {
    /// The channel of the message template.
    channel: ?[]const u8,

    /// The channel subtype this message template applies to.
    channel_subtype: ChannelSubtype,

    /// Whether the version of the message template is activated.
    is_active: bool,

    /// The Amazon Resource Name (ARN) of the knowledge base.
    knowledge_base_arn: []const u8,

    /// The identifier of the knowledge base.
    knowledge_base_id: []const u8,

    /// The Amazon Resource Name (ARN) of the message template.
    message_template_arn: []const u8,

    /// The identifier of the message template.
    message_template_id: []const u8,

    /// The name of the message template.
    name: []const u8,

    /// The version number of the message template version.
    version_number: i64,

    pub const json_field_names = .{
        .channel = "channel",
        .channel_subtype = "channelSubtype",
        .is_active = "isActive",
        .knowledge_base_arn = "knowledgeBaseArn",
        .knowledge_base_id = "knowledgeBaseId",
        .message_template_arn = "messageTemplateArn",
        .message_template_id = "messageTemplateId",
        .name = "name",
        .version_number = "versionNumber",
    };
};
