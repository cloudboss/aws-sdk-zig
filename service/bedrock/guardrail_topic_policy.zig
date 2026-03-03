const GuardrailTopicsTier = @import("guardrail_topics_tier.zig").GuardrailTopicsTier;
const GuardrailTopic = @import("guardrail_topic.zig").GuardrailTopic;

/// Contains details about topics that the guardrail should identify and deny.
///
/// This data type is used in the following API operations:
///
/// * [GetGuardrail response
///   body](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_GetGuardrail.html#API_GetGuardrail_ResponseSyntax)
pub const GuardrailTopicPolicy = struct {
    /// The tier that your guardrail uses for denied topic filters.
    tier: ?GuardrailTopicsTier = null,

    /// A list of policies related to topics that the guardrail should deny.
    topics: []const GuardrailTopic,

    pub const json_field_names = .{
        .tier = "tier",
        .topics = "topics",
    };
};
