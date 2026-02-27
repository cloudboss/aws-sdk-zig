/// Represents the configuration of Automated Reasoning policies within a Amazon
/// Bedrock Guardrail, including the policies to apply and confidence
/// thresholds.
pub const GuardrailAutomatedReasoningPolicy = struct {
    /// The minimum confidence level required for Automated Reasoning policy
    /// violations to trigger guardrail actions. Values range from 0.0 to 1.0.
    confidence_threshold: ?f64,

    /// The list of Automated Reasoning policy ARNs that should be applied as part
    /// of this guardrail configuration.
    policies: []const []const u8,

    pub const json_field_names = .{
        .confidence_threshold = "confidenceThreshold",
        .policies = "policies",
    };
};
