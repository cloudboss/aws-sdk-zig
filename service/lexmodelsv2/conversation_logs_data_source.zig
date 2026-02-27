const ConversationLogsDataSourceFilterBy = @import("conversation_logs_data_source_filter_by.zig").ConversationLogsDataSourceFilterBy;

/// The data source that uses conversation logs.
pub const ConversationLogsDataSource = struct {
    /// The bot alias Id from the conversation logs.
    bot_alias_id: []const u8,

    /// The bot Id from the conversation logs.
    bot_id: []const u8,

    /// The filter for the data source of the conversation log.
    filter: ConversationLogsDataSourceFilterBy,

    /// The locale Id of the conversation log.
    locale_id: []const u8,

    pub const json_field_names = .{
        .bot_alias_id = "botAliasId",
        .bot_id = "botId",
        .filter = "filter",
        .locale_id = "localeId",
    };
};
