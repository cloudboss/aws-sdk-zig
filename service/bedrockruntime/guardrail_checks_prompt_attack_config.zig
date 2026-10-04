const GuardrailChecksPromptAttackCategoryConfig = @import("guardrail_checks_prompt_attack_category_config.zig").GuardrailChecksPromptAttackCategoryConfig;

/// The configuration for the prompt attack check, specifying which categories
/// to evaluate.
pub const GuardrailChecksPromptAttackConfig = struct {
    /// The prompt attack categories to evaluate.
    categories: []const GuardrailChecksPromptAttackCategoryConfig,

    pub const json_field_names = .{
        .categories = "categories",
    };
};
