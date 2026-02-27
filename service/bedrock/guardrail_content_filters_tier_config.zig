const GuardrailContentFiltersTierName = @import("guardrail_content_filters_tier_name.zig").GuardrailContentFiltersTierName;

/// The tier that your guardrail uses for content filters. Consider using a tier
/// that balances performance, accuracy, and compatibility with your existing
/// generative AI workflows.
pub const GuardrailContentFiltersTierConfig = struct {
    /// The tier that your guardrail uses for content filters. Valid values include:
    ///
    /// * `CLASSIC` tier – Provides established guardrails functionality supporting
    ///   English, French, and Spanish languages.
    /// * `STANDARD` tier – Provides a more robust solution than the `CLASSIC` tier
    ///   and has more comprehensive language support. This tier requires that your
    ///   guardrail use [cross-Region
    ///   inference](https://docs.aws.amazon.com/bedrock/latest/userguide/guardrails-cross-region.html).
    tier_name: GuardrailContentFiltersTierName,

    pub const json_field_names = .{
        .tier_name = "tierName",
    };
};
