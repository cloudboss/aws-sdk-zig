const ConversationLogsResponse = @import("conversation_logs_response.zig").ConversationLogsResponse;

/// Provides information about a bot alias.
pub const BotAliasMetadata = struct {
    /// The name of the bot to which the alias points.
    bot_name: ?[]const u8 = null,

    /// The version of the Amazon Lex bot to which the alias points.
    bot_version: ?[]const u8 = null,

    /// Checksum of the bot alias.
    checksum: ?[]const u8 = null,

    /// Settings that determine how Amazon Lex uses conversation logs for the
    /// alias.
    conversation_logs: ?ConversationLogsResponse = null,

    /// The date that the bot alias was created.
    created_date: ?i64 = null,

    /// A description of the bot alias.
    description: ?[]const u8 = null,

    /// The date that the bot alias was updated. When you create a
    /// resource, the creation date and last updated date are the same.
    last_updated_date: ?i64 = null,

    /// The name of the bot alias.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_name = "botName",
        .bot_version = "botVersion",
        .checksum = "checksum",
        .conversation_logs = "conversationLogs",
        .created_date = "createdDate",
        .description = "description",
        .last_updated_date = "lastUpdatedDate",
        .name = "name",
    };
};
