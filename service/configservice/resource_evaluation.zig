const EvaluationMode = @import("evaluation_mode.zig").EvaluationMode;

/// Returns details of a resource evaluation.
pub const ResourceEvaluation = struct {
    /// The mode of an evaluation. The valid values are Detective or Proactive.
    evaluation_mode: ?EvaluationMode = null,

    /// The starting time of an execution.
    evaluation_start_timestamp: ?i64 = null,

    /// The ResourceEvaluationId of a evaluation.
    resource_evaluation_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .evaluation_mode = "EvaluationMode",
        .evaluation_start_timestamp = "EvaluationStartTimestamp",
        .resource_evaluation_id = "ResourceEvaluationId",
    };
};
