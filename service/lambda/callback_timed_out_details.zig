const EventError = @import("event_error.zig").EventError;

/// Contains details about a callback operation that timed out, including
/// timeout duration and any partial results.
pub const CallbackTimedOutDetails = struct {
    /// Details about the callback timeout.
    @"error": EventError,
};
