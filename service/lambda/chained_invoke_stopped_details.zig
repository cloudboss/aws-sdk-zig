const EventError = @import("event_error.zig").EventError;

/// Details about a chained invocation that was stopped.
pub const ChainedInvokeStoppedDetails = struct {
    /// Details about why the chained invocation stopped.
    @"error": EventError,
};
