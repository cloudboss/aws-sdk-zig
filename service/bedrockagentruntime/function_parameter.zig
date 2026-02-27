/// Contains information about a parameter of the function.
///
/// This data type is used in the following API operations:
///
/// * In the `returnControl` field of the [InvokeAgent
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_InvokeAgent.html#API_agent-runtime_InvokeAgent_ResponseSyntax)
pub const FunctionParameter = struct {
    /// The name of the parameter.
    name: ?[]const u8,

    /// The data type of the parameter.
    @"type": ?[]const u8,

    /// The value of the parameter.
    value: ?[]const u8,

    pub const json_field_names = .{
        .name = "name",
        .@"type" = "type",
        .value = "value",
    };
};
