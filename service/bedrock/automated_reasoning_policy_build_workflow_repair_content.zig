const AutomatedReasoningPolicyAnnotation = @import("automated_reasoning_policy_annotation.zig").AutomatedReasoningPolicyAnnotation;

/// Contains content and instructions for repairing or improving an existing
/// Automated Reasoning policy.
pub const AutomatedReasoningPolicyBuildWorkflowRepairContent = struct {
    /// Specific annotations or modifications to apply during the policy repair
    /// process, such as rule corrections or variable updates.
    annotations: []const AutomatedReasoningPolicyAnnotation,

    pub const json_field_names = .{
        .annotations = "annotations",
    };
};
