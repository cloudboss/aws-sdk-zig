const EventResult = @import("event_result.zig").EventResult;

/// Details about a [durable
/// execution](https://docs.aws.amazon.com/lambda/latest/dg/durable-functions.html) that succeeded.
pub const ExecutionSucceededDetails = struct {
    /// The response payload from the successful operation.
    result: EventResult,

    pub const json_field_names = .{
        .result = "Result",
    };
};
