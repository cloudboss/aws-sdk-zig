const EventError = @import("event_error.zig").EventError;

/// Contains details about a failed callback operation, including error
/// information and the reason for failure.
pub const CallbackFailedDetails = struct {
    /// An error object that contains details about the failure.
    @"error": EventError,
};
