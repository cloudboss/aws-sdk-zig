/// The instruction that guides how the Orchestration AI Agent works with a
/// collaborator agent.
pub const MultiAgentInstruction = struct {
    /// Example interactions that illustrate when the Orchestration AI Agent should
    /// engage the collaborator agent.
    examples: ?[]const []const u8 = null,

    /// The natural-language instruction that tells the Orchestration AI Agent when
    /// and how to engage the collaborator agent.
    instruction: ?[]const u8 = null,

    pub const json_field_names = .{
        .examples = "examples",
        .instruction = "instruction",
    };
};
