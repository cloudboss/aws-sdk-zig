/// Contains configurations for a prompt from Prompt management to use in a
/// node.
pub const PromptFlowNodeResourceConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the prompt from Prompt management.
    prompt_arn: []const u8 = "",

    pub const json_field_names = .{
        .prompt_arn = "promptArn",
    };
};
