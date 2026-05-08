/// Configuration for an AgentCore Runtime target. Specifies the agent runtime
/// to route requests to via HTTP.
pub const RuntimeTargetConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the AgentCore Runtime to route requests
    /// to.
    arn: []const u8,

    /// The qualifier for the agent runtime, used to target a specific endpoint
    /// version. If not specified, the default endpoint is used.
    qualifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .qualifier = "qualifier",
    };
};
