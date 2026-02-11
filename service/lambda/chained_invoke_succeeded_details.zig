const EventResult = @import("event_result.zig").EventResult;

/// Details about a chained invocation that succeeded.
pub const ChainedInvokeSucceededDetails = struct {
    /// The response payload from the successful operation.
    result: EventResult,

    pub const json_field_names = .{
        .result = "Result",
    };
};
