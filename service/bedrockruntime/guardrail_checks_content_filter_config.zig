const GuardrailChecksContentFilterCategoryConfig = @import("guardrail_checks_content_filter_category_config.zig").GuardrailChecksContentFilterCategoryConfig;

/// The configuration for the content filter check, specifying which categories
/// to evaluate.
pub const GuardrailChecksContentFilterConfig = struct {
    /// The content filter categories to evaluate.
    categories: []const GuardrailChecksContentFilterCategoryConfig,

    pub const json_field_names = .{
        .categories = "categories",
    };
};
