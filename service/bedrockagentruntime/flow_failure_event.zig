const FlowErrorCode = @import("flow_error_code.zig").FlowErrorCode;

/// Contains information about a failure that occurred at the flow level during
/// a flow execution.
///
/// Flow executions is in preview release for Amazon Bedrock and is subject to
/// change.
pub const FlowFailureEvent = struct {
    /// The error code that identifies the type of failure that occurred.
    error_code: FlowErrorCode,

    /// A descriptive message that provides details about the failure.
    error_message: []const u8,

    /// The timestamp when the failure occurred.
    timestamp: i64,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .timestamp = "timestamp",
    };
};
