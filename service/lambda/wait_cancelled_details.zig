const EventError = @import("event_error.zig").EventError;

/// Details about a wait operation that was cancelled.
pub const WaitCancelledDetails = struct {
    /// Details about why the wait operation was cancelled.
    @"error": ?EventError = null,

    pub const json_field_names = .{
        .@"error" = "Error",
    };
};
