const GuardrailTopic = @import("guardrail_topic.zig").GuardrailTopic;

/// A behavior assessment of a topic policy.
pub const GuardrailTopicPolicyAssessment = struct {
    /// The topics in the assessment.
    topics: []const GuardrailTopic,

    pub const json_field_names = .{
        .topics = "topics",
    };
};
