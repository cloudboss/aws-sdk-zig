/// Model-specific information for the enforced guardrail configuration.
pub const ModelEnforcement = struct {
    /// Models to exclude from enforcement of the guardrail.
    excluded_models: []const []const u8,

    /// Models to enforce the guardrail on.
    included_models: []const []const u8,

    pub const json_field_names = .{
        .excluded_models = "excludedModels",
        .included_models = "includedModels",
    };
};
