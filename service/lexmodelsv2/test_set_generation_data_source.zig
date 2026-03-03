const ConversationLogsDataSource = @import("conversation_logs_data_source.zig").ConversationLogsDataSource;

/// Contains information about the data source from which the test set is
/// generated.
pub const TestSetGenerationDataSource = struct {
    /// Contains information about the bot from which the conversation logs are
    /// sourced.
    conversation_logs_data_source: ?ConversationLogsDataSource = null,

    pub const json_field_names = .{
        .conversation_logs_data_source = "conversationLogsDataSource",
    };
};
