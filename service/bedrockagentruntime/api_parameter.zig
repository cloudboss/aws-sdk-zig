/// Information about a parameter to provide to the API request.
///
/// This data type is used in the following API operations:
///
/// * [InvokeAgent
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_InvokeAgent.html#API_agent-runtime_InvokeAgent_ResponseSyntax)
pub const ApiParameter = struct {
    /// The name of the parameter.
    name: ?[]const u8,

    /// The data type for the parameter.
    type: ?[]const u8,

    /// The value of the parameter.
    value: ?[]const u8,

    pub const json_field_names = .{
        .name = "name",
        .type = "type",
        .value = "value",
    };
};
