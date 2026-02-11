const EventResult = @import("event_result.zig").EventResult;

/// Contains details about a successfully completed callback operation,
/// including the result data and completion timestamp.
pub const CallbackSucceededDetails = struct {
    /// The response payload from the successful operation.
    result: EventResult,

    pub const json_field_names = .{
        .result = "Result",
    };
};
