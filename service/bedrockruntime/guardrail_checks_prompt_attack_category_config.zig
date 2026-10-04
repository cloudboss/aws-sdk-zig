const GuardrailChecksPromptAttackCategory = @import("guardrail_checks_prompt_attack_category.zig").GuardrailChecksPromptAttackCategory;

/// The configuration for a single prompt attack category to evaluate.
pub const GuardrailChecksPromptAttackCategoryConfig = struct {
    /// The prompt attack category to evaluate.
    category: GuardrailChecksPromptAttackCategory,

    pub const json_field_names = .{
        .category = "category",
    };
};
