const EventError = @import("event_error.zig").EventError;

/// Details about a chained invocation that timed out.
pub const ChainedInvokeTimedOutDetails = struct {
    /// Details about the chained invocation timeout.
    @"error": EventError,

    pub const json_field_names = .{
        .@"error" = "Error",
    };
};
