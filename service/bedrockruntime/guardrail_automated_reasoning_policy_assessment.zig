const GuardrailAutomatedReasoningFinding = @import("guardrail_automated_reasoning_finding.zig").GuardrailAutomatedReasoningFinding;

/// Contains the results of automated reasoning policy evaluation, including
/// logical findings about the validity of claims made in the input content.
pub const GuardrailAutomatedReasoningPolicyAssessment = struct {
    /// List of logical validation results produced by evaluating the input content
    /// against automated reasoning policies.
    findings: ?[]const GuardrailAutomatedReasoningFinding,

    pub const json_field_names = .{
        .findings = "findings",
    };
};
