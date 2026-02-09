const EventError = @import("event_error.zig").EventError;

/// Details about a failed [durable
/// execution](https://docs.aws.amazon.com/lambda/latest/dg/durable-functions.html).
pub const ExecutionFailedDetails = struct {
    /// Details about the execution failure.
    @"error": EventError,
};
