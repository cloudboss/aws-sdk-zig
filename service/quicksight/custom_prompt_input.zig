const CustomPromptProfile = @import("custom_prompt_profile.zig").CustomPromptProfile;
const CustomPromptInputParameters = @import("custom_prompt_input_parameters.zig").CustomPromptInputParameters;

/// The custom prompt input for an agent. This is a union type that can be
/// either an existing prompt profile or new prompt parameters.
pub const CustomPromptInput = union(enum) {
    /// An existing custom prompt profile to use for the agent.
    existing_prompt: ?CustomPromptProfile,
    /// New custom prompt parameters to configure for the agent.
    new_prompt: ?CustomPromptInputParameters,

    pub const json_field_names = .{
        .existing_prompt = "ExistingPrompt",
        .new_prompt = "NewPrompt",
    };
};
