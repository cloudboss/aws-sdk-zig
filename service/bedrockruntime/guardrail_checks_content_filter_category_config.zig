const GuardrailChecksContentFilterCategory = @import("guardrail_checks_content_filter_category.zig").GuardrailChecksContentFilterCategory;

/// The configuration for a single content filter category to evaluate.
pub const GuardrailChecksContentFilterCategoryConfig = struct {
    /// The content filter category to evaluate.
    category: GuardrailChecksContentFilterCategory,

    pub const json_field_names = .{
        .category = "category",
    };
};
