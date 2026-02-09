const EventError = @import("event_error.zig").EventError;

/// Details about a [durable
/// execution](https://docs.aws.amazon.com/lambda/latest/dg/durable-functions.html) that stopped.
pub const ExecutionStoppedDetails = struct {
    /// Details about why the execution stopped.
    @"error": EventError,
};
