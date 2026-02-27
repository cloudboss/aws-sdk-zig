/// Provides information about a session.
pub const Session = struct {
    /// The duration of the session, in milliseconds.
    duration: ?i32,

    /// The unique identifier for the session.
    id: []const u8,

    /// The date and time when the session began.
    start_timestamp: []const u8,

    /// The date and time when the session ended.
    stop_timestamp: ?[]const u8,

    pub const json_field_names = .{
        .duration = "Duration",
        .id = "Id",
        .start_timestamp = "StartTimestamp",
        .stop_timestamp = "StopTimestamp",
    };
};
