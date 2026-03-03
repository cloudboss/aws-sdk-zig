const FlowExecutionErrorType = @import("flow_execution_error_type.zig").FlowExecutionErrorType;

/// Contains information about an error that occurred during an flow execution.
///
/// Flow executions is in preview release for Amazon Bedrock and is subject to
/// change.
pub const FlowExecutionError = struct {
    /// The error code for the type of error that occurred.
    @"error": ?FlowExecutionErrorType = null,

    /// A descriptive message that provides details about the error.
    message: ?[]const u8 = null,

    /// The name of the node in the flow where the error occurred (if applicable).
    node_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .@"error" = "error",
        .message = "message",
        .node_name = "nodeName",
    };
};
