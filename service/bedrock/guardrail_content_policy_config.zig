const GuardrailContentFilterConfig = @import("guardrail_content_filter_config.zig").GuardrailContentFilterConfig;
const GuardrailContentFiltersTierConfig = @import("guardrail_content_filters_tier_config.zig").GuardrailContentFiltersTierConfig;

/// Contains details about how to handle harmful content.
pub const GuardrailContentPolicyConfig = struct {
    /// Contains the type of the content filter and how strongly it should apply to
    /// prompts and model responses.
    filters_config: []const GuardrailContentFilterConfig,

    /// The tier that your guardrail uses for content filters.
    tier_config: ?GuardrailContentFiltersTierConfig,

    pub const json_field_names = .{
        .filters_config = "filtersConfig",
        .tier_config = "tierConfig",
    };
};
