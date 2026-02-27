const GuardrailTopicConfig = @import("guardrail_topic_config.zig").GuardrailTopicConfig;

/// Contains details about topics that the AI Guardrail should identify and
/// deny.
pub const AIGuardrailTopicPolicyConfig = struct {
    /// A list of policies related to topics that the AI Guardrail should deny.
    topics_config: []const GuardrailTopicConfig,

    pub const json_field_names = .{
        .topics_config = "topicsConfig",
    };
};
