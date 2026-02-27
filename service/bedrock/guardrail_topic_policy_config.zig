const GuardrailTopicsTierConfig = @import("guardrail_topics_tier_config.zig").GuardrailTopicsTierConfig;
const GuardrailTopicConfig = @import("guardrail_topic_config.zig").GuardrailTopicConfig;

/// Contains details about topics that the guardrail should identify and deny.
pub const GuardrailTopicPolicyConfig = struct {
    /// The tier that your guardrail uses for denied topic filters.
    tier_config: ?GuardrailTopicsTierConfig,

    /// A list of policies related to topics that the guardrail should deny.
    topics_config: []const GuardrailTopicConfig,

    pub const json_field_names = .{
        .tier_config = "tierConfig",
        .topics_config = "topicsConfig",
    };
};
