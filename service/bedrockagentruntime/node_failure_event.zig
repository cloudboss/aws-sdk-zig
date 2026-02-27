const NodeErrorCode = @import("node_error_code.zig").NodeErrorCode;

/// Contains information about a failure that occurred at a specific node during
/// a flow execution.
///
/// Flow executions is in preview release for Amazon Bedrock and is subject to
/// change.
pub const NodeFailureEvent = struct {
    /// The error code that identifies the type of failure that occurred at the
    /// node.
    error_code: NodeErrorCode,

    /// A descriptive message that provides details about the node failure.
    error_message: []const u8,

    /// The name of the node where the failure occurred.
    node_name: []const u8,

    /// The timestamp when the node failure occurred.
    timestamp: i64,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .node_name = "nodeName",
        .timestamp = "timestamp",
    };
};
