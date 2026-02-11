const EventResult = @import("event_result.zig").EventResult;

/// Details about a context that succeeded.
pub const ContextSucceededDetails = struct {
    /// The JSON response payload from the successful context.
    result: EventResult,

    pub const json_field_names = .{
        .result = "Result",
    };
};
