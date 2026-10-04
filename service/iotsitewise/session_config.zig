const TimeInNanos = @import("time_in_nanos.zig").TimeInNanos;

/// Contains the session configuration for a session-type dataset.
pub const SessionConfig = struct {
    /// The nanosecond-precision end time of the session.
    session_end_timestamp: TimeInNanos,

    /// The nanosecond-precision start time of the session.
    session_start_timestamp: TimeInNanos,

    pub const json_field_names = .{
        .session_end_timestamp = "sessionEndTimestamp",
        .session_start_timestamp = "sessionStartTimestamp",
    };
};
