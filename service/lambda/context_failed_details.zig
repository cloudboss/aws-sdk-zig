const EventError = @import("event_error.zig").EventError;

/// Details about a context that failed.
pub const ContextFailedDetails = struct {
    /// Details about the context failure.
    @"error": EventError,
};
