const OnFailure = @import("on_failure.zig").OnFailure;
const OnSuccess = @import("on_success.zig").OnSuccess;

/// A configuration object that specifies the destination of an event after
/// Lambda processes it. For more information, see [Adding a
/// destination](https://docs.aws.amazon.com/lambda/latest/dg/invocation-async-retain-records.html#invocation-async-destinations).
pub const DestinationConfig = struct {
    /// The destination configuration for failed invocations.
    on_failure: ?OnFailure,

    /// The destination configuration for successful invocations. Not supported in
    /// `CreateEventSourceMapping` or `UpdateEventSourceMapping`.
    on_success: ?OnSuccess,

    pub const json_field_names = .{
        .on_failure = "OnFailure",
        .on_success = "OnSuccess",
    };
};
