const GuardrailContentPolicyAssessment = @import("guardrail_content_policy_assessment.zig").GuardrailContentPolicyAssessment;
const GuardrailSensitiveInformationPolicyAssessment = @import("guardrail_sensitive_information_policy_assessment.zig").GuardrailSensitiveInformationPolicyAssessment;
const GuardrailTopicPolicyAssessment = @import("guardrail_topic_policy_assessment.zig").GuardrailTopicPolicyAssessment;
const GuardrailWordPolicyAssessment = @import("guardrail_word_policy_assessment.zig").GuardrailWordPolicyAssessment;

/// Assessment details of the content analyzed by Guardrails.
pub const GuardrailAssessment = struct {
    /// Content policy details of the Guardrail.
    content_policy: ?GuardrailContentPolicyAssessment = null,

    /// Sensitive Information policy details of Guardrail.
    sensitive_information_policy: ?GuardrailSensitiveInformationPolicyAssessment = null,

    /// Topic policy details of the Guardrail.
    topic_policy: ?GuardrailTopicPolicyAssessment = null,

    /// Word policy details of the Guardrail.
    word_policy: ?GuardrailWordPolicyAssessment = null,

    pub const json_field_names = .{
        .content_policy = "contentPolicy",
        .sensitive_information_policy = "sensitiveInformationPolicy",
        .topic_policy = "topicPolicy",
        .word_policy = "wordPolicy",
    };
};
