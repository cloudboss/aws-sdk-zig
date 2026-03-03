/// A stage session begins when the first participant joins a stage and ends
/// after the last
/// participant leaves the stage. A stage session helps with debugging stages by
/// grouping
/// events and participants into shorter periods of time (i.e., a session),
/// which is helpful
/// when stages are used over long periods of time.
pub const StageSession = struct {
    /// ISO 8601 timestamp (returned as a string) when the stage session ended. This
    /// is null if
    /// the stage is active.
    end_time: ?i64 = null,

    /// ID of the session within the stage.
    session_id: ?[]const u8 = null,

    /// ISO 8601 timestamp (returned as a string) when this stage session began.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .end_time = "endTime",
        .session_id = "sessionId",
        .start_time = "startTime",
    };
};
