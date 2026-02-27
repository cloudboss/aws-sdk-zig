/// Defines an agent node in your flow. You specify the agent to invoke at this
/// point in the flow. For more information, see [Node types in a
/// flow](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-nodes.html)
/// in the Amazon Bedrock User Guide.
pub const AgentFlowNodeConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the alias of the agent to invoke.
    agent_alias_arn: []const u8 = "",

    pub const json_field_names = .{
        .agent_alias_arn = "agentAliasArn",
    };
};
