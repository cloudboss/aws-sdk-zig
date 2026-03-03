const EventError = @import("event_error.zig").EventError;

/// Details about a [durable
/// execution](https://docs.aws.amazon.com/lambda/latest/dg/durable-functions.html) that timed out.
pub const ExecutionTimedOutDetails = struct {
    /// Details about the execution timeout.
    @"error": ?EventError = null,

    pub const json_field_names = .{
        .@"error" = "Error",
    };
};
