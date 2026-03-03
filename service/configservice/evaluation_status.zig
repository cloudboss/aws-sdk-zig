const ResourceEvaluationStatus = @import("resource_evaluation_status.zig").ResourceEvaluationStatus;

/// Returns status details of an evaluation.
pub const EvaluationStatus = struct {
    /// An explanation for failed execution status.
    failure_reason: ?[]const u8 = null,

    /// The status of an execution. The valid values are In_Progress, Succeeded or
    /// Failed.
    status: ResourceEvaluationStatus,

    pub const json_field_names = .{
        .failure_reason = "FailureReason",
        .status = "Status",
    };
};
