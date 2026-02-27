const ConversationLogsInputModeFilter = @import("conversation_logs_input_mode_filter.zig").ConversationLogsInputModeFilter;

/// The selected data source to filter the conversation log.
pub const ConversationLogsDataSourceFilterBy = struct {
    /// The end time for the conversation log.
    end_time: i64,

    /// The selection to filter by input mode for the conversation logs.
    input_mode: ConversationLogsInputModeFilter,

    /// The start time for the conversation log.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "endTime",
        .input_mode = "inputMode",
        .start_time = "startTime",
    };
};
