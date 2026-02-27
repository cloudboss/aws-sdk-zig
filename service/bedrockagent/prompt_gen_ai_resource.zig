const PromptAgentResource = @import("prompt_agent_resource.zig").PromptAgentResource;

/// Contains specifications for a generative AI resource with which to use the
/// prompt. For more information, see [Create a prompt using Prompt
/// management](https://docs.aws.amazon.com/bedrock/latest/userguide/prompt-management-create.html).
pub const PromptGenAiResource = union(enum) {
    /// Specifies an Amazon Bedrock agent with which to use the prompt.
    agent: ?PromptAgentResource,

    pub const json_field_names = .{
        .agent = "agent",
    };
};
