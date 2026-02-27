const GuardrailContentFilter = @import("guardrail_content_filter.zig").GuardrailContentFilter;
const GuardrailContentFiltersTier = @import("guardrail_content_filters_tier.zig").GuardrailContentFiltersTier;

/// Contains details about how to handle harmful content.
///
/// This data type is used in the following API operations:
///
/// * [GetGuardrail response
///   body](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_GetGuardrail.html#API_GetGuardrail_ResponseSyntax)
pub const GuardrailContentPolicy = struct {
    /// Contains the type of the content filter and how strongly it should apply to
    /// prompts and model responses.
    filters: ?[]const GuardrailContentFilter,

    /// The tier that your guardrail uses for content filters.
    tier: ?GuardrailContentFiltersTier,

    pub const json_field_names = .{
        .filters = "filters",
        .tier = "tier",
    };
};
