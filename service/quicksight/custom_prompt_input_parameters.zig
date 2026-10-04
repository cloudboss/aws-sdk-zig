/// The parameters for configuring a custom prompt for an agent.
pub const CustomPromptInputParameters = struct {
    /// Custom instructions for the agent's behavior.
    custom_instructions: ?[]const u8 = null,

    /// Instructions that define the agent's identity and persona.
    identity: ?[]const u8 = null,

    /// Instructions for the desired output style.
    output_style: ?[]const u8 = null,

    /// Instructions for the desired response length.
    response_length: ?[]const u8 = null,

    /// Instructions for the desired tone of responses.
    tone: ?[]const u8 = null,

    pub const json_field_names = .{
        .custom_instructions = "CustomInstructions",
        .identity = "Identity",
        .output_style = "OutputStyle",
        .response_length = "ResponseLength",
        .tone = "Tone",
    };
};
