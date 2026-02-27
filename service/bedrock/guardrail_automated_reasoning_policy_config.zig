/// Configuration settings for integrating Automated Reasoning policies with
/// Amazon Bedrock Guardrails.
pub const GuardrailAutomatedReasoningPolicyConfig = struct {
    /// The confidence threshold for triggering guardrail actions based on Automated
    /// Reasoning policy violations.
    confidence_threshold: ?f64,

    /// The list of Automated Reasoning policy ARNs to include in the guardrail
    /// configuration.
    policies: []const []const u8,

    pub const json_field_names = .{
        .confidence_threshold = "confidenceThreshold",
        .policies = "policies",
    };
};
