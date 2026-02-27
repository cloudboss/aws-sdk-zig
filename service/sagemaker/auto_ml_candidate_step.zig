const CandidateStepType = @import("candidate_step_type.zig").CandidateStepType;

/// Information about the steps for a candidate and what step it is working on.
pub const AutoMLCandidateStep = struct {
    /// The ARN for the candidate's step.
    candidate_step_arn: []const u8,

    /// The name for the candidate's step.
    candidate_step_name: []const u8,

    /// Whether the candidate is at the transform, training, or processing step.
    candidate_step_type: CandidateStepType,

    pub const json_field_names = .{
        .candidate_step_arn = "CandidateStepArn",
        .candidate_step_name = "CandidateStepName",
        .candidate_step_type = "CandidateStepType",
    };
};
