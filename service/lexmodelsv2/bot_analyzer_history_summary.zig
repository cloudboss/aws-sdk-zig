const BotAnalyzerStatus = @import("bot_analyzer_status.zig").BotAnalyzerStatus;

/// Contains summary information about a historical bot analysis execution.
pub const BotAnalyzerHistorySummary = struct {
    /// The unique identifier for the analysis request.
    bot_analyzer_request_id: []const u8,

    /// The status of the historical analysis execution.
    ///
    /// Valid Values: `Processing | Available | Failed | Stopping | Stopped`
    bot_analyzer_status: BotAnalyzerStatus,

    /// The date and time when the analysis was initiated.
    creation_date_time: ?i64 = null,

    pub const json_field_names = .{
        .bot_analyzer_request_id = "botAnalyzerRequestId",
        .bot_analyzer_status = "botAnalyzerStatus",
        .creation_date_time = "creationDateTime",
    };
};
