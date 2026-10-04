const GuardrailChecksPromptAttackCategory = @import("guardrail_checks_prompt_attack_category.zig").GuardrailChecksPromptAttackCategory;

/// The evaluation result for a single prompt attack category.
pub const GuardrailChecksPromptAttackResultEntry = struct {
    /// The prompt attack category that was evaluated.
    category: GuardrailChecksPromptAttackCategory,

    /// The severity score for the category, ranging from 0.0 to 1.0. Higher values
    /// indicate greater severity.
    severity_score: f64,

    pub const json_field_names = .{
        .category = "category",
        .severity_score = "severityScore",
    };
};
