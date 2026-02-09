const ErrorObject = @import("error_object.zig").ErrorObject;

/// Contains details about a chained function invocation in a durable execution,
/// including the target function and invocation parameters.
pub const ChainedInvokeDetails = struct {
    /// Details about the chained invocation failure.
    @"error": ?ErrorObject,

    /// The response payload from the chained invocation.
    result: ?[]const u8,
};
