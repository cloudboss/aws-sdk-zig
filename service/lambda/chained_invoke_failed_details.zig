const EventError = @import("event_error.zig").EventError;

/// Contains details about a failed chained function invocation, including error
/// information and failure reason.
pub const ChainedInvokeFailedDetails = struct {
    /// Details about the chained invocation failure.
    @"error": EventError,

    pub const json_field_names = .{
        .@"error" = "Error",
    };
};
