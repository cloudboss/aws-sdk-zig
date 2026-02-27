const AutomatedReasoningPolicyAnnotation = @import("automated_reasoning_policy_annotation.zig").AutomatedReasoningPolicyAnnotation;
const AutomatedReasoningPolicyBuildStep = @import("automated_reasoning_policy_build_step.zig").AutomatedReasoningPolicyBuildStep;
const AutomatedReasoningPolicyAnnotationStatus = @import("automated_reasoning_policy_annotation_status.zig").AutomatedReasoningPolicyAnnotationStatus;

/// Represents a single entry in the policy build log, containing information
/// about a specific step or event in the build process.
pub const AutomatedReasoningPolicyBuildLogEntry = struct {
    /// The annotation or operation that was being processed when this log entry was
    /// created.
    annotation: AutomatedReasoningPolicyAnnotation,

    /// Detailed information about the specific build steps that were executed,
    /// including any sub-operations or transformations.
    build_steps: []const AutomatedReasoningPolicyBuildStep,

    /// The status of the build step (e.g., SUCCESS, FAILED, IN_PROGRESS).
    status: AutomatedReasoningPolicyAnnotationStatus,

    pub const json_field_names = .{
        .annotation = "annotation",
        .build_steps = "buildSteps",
        .status = "status",
    };
};
