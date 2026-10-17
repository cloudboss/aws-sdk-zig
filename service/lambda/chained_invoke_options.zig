/// Configuration options for chained function invocations in durable
/// executions, including retry settings and timeout configuration.
pub const ChainedInvokeOptions = struct {
    /// The name or ARN of the Lambda function to invoke.
    function_name: []const u8,

    /// The tenant identifier for the chained invocation.
    tenant_id: ?[]const u8 = null,

    /// The optional X-Ray trace header to use when starting the chained invocation.
    /// If you omit this value, the child invocation inherits the parent durable
    /// execution's trace header.
    ///
    /// Specify this value on the `START` update for the chained invocation
    /// operation. For more information about the header format, see [Tracing
    /// header](https://docs.aws.amazon.com/xray/latest/devguide/xray-concepts.html#xray-concepts-tracingheader) in the *X-Ray Developer Guide*.
    x_amzn_trace_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .function_name = "FunctionName",
        .tenant_id = "TenantId",
        .x_amzn_trace_id = "XAmznTraceId",
    };
};
