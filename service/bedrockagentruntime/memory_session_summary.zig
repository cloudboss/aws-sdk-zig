/// Contains details of a session summary.
pub const MemorySessionSummary = struct {
    /// The unique identifier of the memory where the session summary is stored.
    memory_id: ?[]const u8 = null,

    /// The time when the memory duration for the session is set to end.
    session_expiry_time: ?i64 = null,

    /// The identifier for this session.
    session_id: ?[]const u8 = null,

    /// The start time for this session.
    session_start_time: ?i64 = null,

    /// The summarized text for this session.
    summary_text: ?[]const u8 = null,

    pub const json_field_names = .{
        .memory_id = "memoryId",
        .session_expiry_time = "sessionExpiryTime",
        .session_id = "sessionId",
        .session_start_time = "sessionStartTime",
        .summary_text = "summaryText",
    };
};
