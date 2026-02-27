/// Contains specifications for an Amazon Bedrock agent with which to use the
/// prompt. For more information, see [Create a prompt using Prompt
/// management](https://docs.aws.amazon.com/bedrock/latest/userguide/prompt-management-create.html) and [Automate tasks in your application using conversational agents](https://docs.aws.amazon.com/bedrock/latest/userguide/agents.html).
pub const PromptAgentResource = struct {
    /// The ARN of the agent with which to use the prompt.
    agent_identifier: []const u8,

    pub const json_field_names = .{
        .agent_identifier = "agentIdentifier",
    };
};
