const EventInput = @import("event_input.zig").EventInput;

/// Contains details about a chained function invocation that has started
/// execution, including start time and execution context.
pub const ChainedInvokeStartedDetails = struct {
    /// The Amazon Resource Name (ARN) that identifies the durable execution.
    durable_execution_arn: ?[]const u8 = null,

    /// The version of the function that was executed.
    executed_version: ?[]const u8 = null,

    /// The name or ARN of the Lambda function being invoked.
    function_name: []const u8,

    /// The JSON input payload provided to the chained invocation.
    input: ?EventInput = null,

    /// The tenant identifier for the chained invocation.
    tenant_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .durable_execution_arn = "DurableExecutionArn",
        .executed_version = "ExecutedVersion",
        .function_name = "FunctionName",
        .input = "Input",
        .tenant_id = "TenantId",
    };
};
