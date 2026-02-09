const EventError = @import("event_error.zig").EventError;

/// Details about a function invocation that completed.
pub const InvocationCompletedDetails = struct {
    /// The date and time when the invocation ended, in [ISO-8601
    /// format](https://www.w3.org/TR/NOTE-datetime) (YYYY-MM-DDThh:mm:ss.sTZD).
    end_timestamp: i64,

    /// Details about the invocation failure.
    @"error": ?EventError,

    /// The request ID for the invocation.
    request_id: []const u8,

    /// The date and time when the invocation started, in [ISO-8601
    /// format](https://www.w3.org/TR/NOTE-datetime) (YYYY-MM-DDThh:mm:ss.sTZD).
    start_timestamp: i64,
};
