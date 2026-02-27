const GuardrailTopic = @import("guardrail_topic.zig").GuardrailTopic;

/// The details of the policy assessment used in the Guardrail.
pub const GuardrailTopicPolicyAssessment = struct {
    /// The topic details of the policy assessment used in the Guardrail.
    topics: ?[]const GuardrailTopic,

    pub const json_field_names = .{
        .topics = "topics",
    };
};
