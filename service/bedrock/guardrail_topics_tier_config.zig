const GuardrailTopicsTierName = @import("guardrail_topics_tier_name.zig").GuardrailTopicsTierName;

/// The tier that your guardrail uses for denied topic filters. Consider using a
/// tier that balances performance, accuracy, and compatibility with your
/// existing generative AI workflows.
pub const GuardrailTopicsTierConfig = struct {
    /// The tier that your guardrail uses for denied topic filters. Valid values
    /// include:
    ///
    /// * `CLASSIC` tier – Provides established guardrails functionality supporting
    ///   English, French, and Spanish languages.
    /// * `STANDARD` tier – Provides a more robust solution than the `CLASSIC` tier
    ///   and has more comprehensive language support. This tier requires that your
    ///   guardrail use [cross-Region
    ///   inference](https://docs.aws.amazon.com/bedrock/latest/userguide/guardrails-cross-region.html).
    tier_name: GuardrailTopicsTierName,

    pub const json_field_names = .{
        .tier_name = "tierName",
    };
};
