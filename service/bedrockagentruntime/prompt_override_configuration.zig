const PromptConfiguration = @import("prompt_configuration.zig").PromptConfiguration;

/// Contains configurations to override prompts in different parts of an agent
/// sequence. For more information, see [Advanced
/// prompts](https://docs.aws.amazon.com/bedrock/latest/userguide/advanced-prompts.html).
pub const PromptOverrideConfiguration = struct {
    /// The ARN of the Lambda function to use when parsing the raw foundation model
    /// output in parts of the agent sequence. If you specify this field, at least
    /// one of the `promptConfigurations` must contain a `parserMode` value that is
    /// set to `OVERRIDDEN`. For more information, see [Parser Lambda function in
    /// Amazon Bedrock
    /// Agents](https://docs.aws.amazon.com/bedrock/latest/userguide/lambda-parser.html).
    override_lambda: ?[]const u8,

    /// Contains configurations to override a prompt template in one part of an
    /// agent sequence. For more information, see [Advanced
    /// prompts](https://docs.aws.amazon.com/bedrock/latest/userguide/advanced-prompts.html).
    prompt_configurations: []const PromptConfiguration,

    pub const json_field_names = .{
        .override_lambda = "overrideLambda",
        .prompt_configurations = "promptConfigurations",
    };
};
