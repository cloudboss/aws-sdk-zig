/// The custom prompt interface configuration that defines how an agent's prompt
/// is configured.
pub const CustomPromptInterface = struct {
    /// Custom instructions for the agent's behavior.
    custom_instructions: ?[]const u8 = null,

    /// Instructions that define the agent's identity and persona.
    identity: ?[]const u8 = null,

    /// The identifier of the model profile.
    model_profile_id: []const u8,

    /// Instructions for the desired output style.
    output_style: ?[]const u8 = null,

    /// A summary of the custom prompt configuration.
    prompt_summary: ?[]const u8 = null,

    /// The Amazon Web Services account ID for the Q Business service.
    qbs_aws_account_id: []const u8,

    /// Instructions for the desired response length.
    response_length: ?[]const u8 = null,

    /// The subscription identifier.
    subscription_id: []const u8,

    /// Instructions for the desired tone of responses.
    tone: ?[]const u8 = null,

    pub const json_field_names = .{
        .custom_instructions = "CustomInstructions",
        .identity = "Identity",
        .model_profile_id = "ModelProfileId",
        .output_style = "OutputStyle",
        .prompt_summary = "promptSummary",
        .qbs_aws_account_id = "QbsAwsAccountId",
        .response_length = "ResponseLength",
        .subscription_id = "SubscriptionId",
        .tone = "Tone",
    };
};
