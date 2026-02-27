const GuardrailContentFilterConfig = @import("guardrail_content_filter_config.zig").GuardrailContentFilterConfig;

/// Contains details about how to handle harmful content.
pub const AIGuardrailContentPolicyConfig = struct {
    /// Contains the type of the content filter and how strongly it should apply to
    /// prompts and model responses.
    filters_config: []const GuardrailContentFilterConfig,

    pub const json_field_names = .{
        .filters_config = "filtersConfig",
    };
};
