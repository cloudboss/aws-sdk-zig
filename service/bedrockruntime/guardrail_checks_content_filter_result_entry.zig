const GuardrailChecksContentFilterCategory = @import("guardrail_checks_content_filter_category.zig").GuardrailChecksContentFilterCategory;

/// The evaluation result for a single content filter category.
pub const GuardrailChecksContentFilterResultEntry = struct {
    /// The content filter category that was evaluated.
    category: GuardrailChecksContentFilterCategory,

    /// The severity score for the category, ranging from 0.0 to 1.0. Higher values
    /// indicate greater severity.
    severity_score: f64,

    pub const json_field_names = .{
        .category = "category",
        .severity_score = "severityScore",
    };
};
