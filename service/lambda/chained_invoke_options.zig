/// Configuration options for chained function invocations in durable
/// executions, including retry settings and timeout configuration.
pub const ChainedInvokeOptions = struct {
    /// The name or ARN of the Lambda function to invoke.
    function_name: []const u8,

    /// The tenant identifier for the chained invocation.
    tenant_id: ?[]const u8,
};
