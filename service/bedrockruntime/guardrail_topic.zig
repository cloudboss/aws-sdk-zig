const GuardrailTopicPolicyAction = @import("guardrail_topic_policy_action.zig").GuardrailTopicPolicyAction;
const GuardrailTopicType = @import("guardrail_topic_type.zig").GuardrailTopicType;

/// Information about a topic guardrail.
pub const GuardrailTopic = struct {
    /// The action the guardrail should take when it intervenes on a topic.
    action: GuardrailTopicPolicyAction,

    /// Indicates whether topic content that breaches the guardrail configuration is
    /// detected.
    detected: ?bool,

    /// The name for the guardrail.
    name: []const u8,

    /// The type behavior that the guardrail should perform when the model detects
    /// the topic.
    @"type": GuardrailTopicType,

    pub const json_field_names = .{
        .action = "action",
        .detected = "detected",
        .name = "name",
        .@"type" = "type",
    };
};
