/// The details on the use of the guardrail.
pub const GuardrailUsage = struct {
    /// The number of automated reasoning policies that were processed during the
    /// guardrail evaluation.
    automated_reasoning_policies: ?i32,

    /// The number of text units processed by the automated reasoning policy.
    automated_reasoning_policy_units: ?i32,

    /// The content policy image units processed by the guardrail.
    content_policy_image_units: ?i32,

    /// The content policy units processed by the guardrail.
    content_policy_units: i32,

    /// The contextual grounding policy units processed by the guardrail.
    contextual_grounding_policy_units: i32,

    /// The sensitive information policy free units processed by the guardrail.
    sensitive_information_policy_free_units: i32,

    /// The sensitive information policy units processed by the guardrail.
    sensitive_information_policy_units: i32,

    /// The topic policy units processed by the guardrail.
    topic_policy_units: i32,

    /// The word policy units processed by the guardrail.
    word_policy_units: i32,

    pub const json_field_names = .{
        .automated_reasoning_policies = "automatedReasoningPolicies",
        .automated_reasoning_policy_units = "automatedReasoningPolicyUnits",
        .content_policy_image_units = "contentPolicyImageUnits",
        .content_policy_units = "contentPolicyUnits",
        .contextual_grounding_policy_units = "contextualGroundingPolicyUnits",
        .sensitive_information_policy_free_units = "sensitiveInformationPolicyFreeUnits",
        .sensitive_information_policy_units = "sensitiveInformationPolicyUnits",
        .topic_policy_units = "topicPolicyUnits",
        .word_policy_units = "wordPolicyUnits",
    };
};
