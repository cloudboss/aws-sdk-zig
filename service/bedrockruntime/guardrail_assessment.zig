const AppliedGuardrailDetails = @import("applied_guardrail_details.zig").AppliedGuardrailDetails;
const GuardrailAutomatedReasoningPolicyAssessment = @import("guardrail_automated_reasoning_policy_assessment.zig").GuardrailAutomatedReasoningPolicyAssessment;
const GuardrailContentPolicyAssessment = @import("guardrail_content_policy_assessment.zig").GuardrailContentPolicyAssessment;
const GuardrailContextualGroundingPolicyAssessment = @import("guardrail_contextual_grounding_policy_assessment.zig").GuardrailContextualGroundingPolicyAssessment;
const GuardrailInvocationMetrics = @import("guardrail_invocation_metrics.zig").GuardrailInvocationMetrics;
const GuardrailSensitiveInformationPolicyAssessment = @import("guardrail_sensitive_information_policy_assessment.zig").GuardrailSensitiveInformationPolicyAssessment;
const GuardrailTopicPolicyAssessment = @import("guardrail_topic_policy_assessment.zig").GuardrailTopicPolicyAssessment;
const GuardrailWordPolicyAssessment = @import("guardrail_word_policy_assessment.zig").GuardrailWordPolicyAssessment;

/// A behavior assessment of the guardrail policies used in a call to the
/// Converse API.
pub const GuardrailAssessment = struct {
    applied_guardrail_details: ?AppliedGuardrailDetails,

    /// The automated reasoning policy assessment results, including logical
    /// validation findings for the input content.
    automated_reasoning_policy: ?GuardrailAutomatedReasoningPolicyAssessment,

    /// The content policy.
    content_policy: ?GuardrailContentPolicyAssessment,

    /// The contextual grounding policy used for the guardrail assessment.
    contextual_grounding_policy: ?GuardrailContextualGroundingPolicyAssessment,

    /// The invocation metrics for the guardrail assessment.
    invocation_metrics: ?GuardrailInvocationMetrics,

    /// The sensitive information policy.
    sensitive_information_policy: ?GuardrailSensitiveInformationPolicyAssessment,

    /// The topic policy.
    topic_policy: ?GuardrailTopicPolicyAssessment,

    /// The word policy.
    word_policy: ?GuardrailWordPolicyAssessment,

    pub const json_field_names = .{
        .applied_guardrail_details = "appliedGuardrailDetails",
        .automated_reasoning_policy = "automatedReasoningPolicy",
        .content_policy = "contentPolicy",
        .contextual_grounding_policy = "contextualGroundingPolicy",
        .invocation_metrics = "invocationMetrics",
        .sensitive_information_policy = "sensitiveInformationPolicy",
        .topic_policy = "topicPolicy",
        .word_policy = "wordPolicy",
    };
};
