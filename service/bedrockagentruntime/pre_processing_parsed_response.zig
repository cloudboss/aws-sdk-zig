/// Details about the response from the Lambda parsing of the output from the
/// pre-processing step.
pub const PreProcessingParsedResponse = struct {
    /// Whether the user input is valid or not. If `false`, the agent doesn't
    /// proceed to orchestration.
    is_valid: ?bool = null,

    /// The text returned by the parsing of the pre-processing step, explaining the
    /// steps that the agent plans to take in orchestration, if the user input is
    /// valid.
    rationale: ?[]const u8 = null,

    pub const json_field_names = .{
        .is_valid = "isValid",
        .rationale = "rationale",
    };
};
