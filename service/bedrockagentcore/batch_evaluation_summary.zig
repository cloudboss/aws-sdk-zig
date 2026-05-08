const EvaluationJobResults = @import("evaluation_job_results.zig").EvaluationJobResults;
const Evaluator = @import("evaluator.zig").Evaluator;
const BatchEvaluationStatus = @import("batch_evaluation_status.zig").BatchEvaluationStatus;

/// Summary representation for list responses
pub const BatchEvaluationSummary = struct {
    /// The Amazon Resource Name (ARN) of the batch evaluation.
    batch_evaluation_arn: []const u8,

    /// The unique identifier of the batch evaluation.
    batch_evaluation_id: []const u8,

    /// The name of the batch evaluation.
    batch_evaluation_name: []const u8,

    /// The timestamp when the batch evaluation was created.
    created_at: i64,

    /// The description of the batch evaluation.
    description: ?[]const u8 = null,

    /// The error details if the batch evaluation encountered failures.
    error_details: ?[]const []const u8 = null,

    /// The aggregated evaluation results.
    evaluation_results: ?EvaluationJobResults = null,

    /// The list of evaluators applied during the batch evaluation.
    evaluators: ?[]const Evaluator = null,

    /// The current status of the batch evaluation.
    status: BatchEvaluationStatus,

    /// The timestamp when the batch evaluation was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .batch_evaluation_arn = "batchEvaluationArn",
        .batch_evaluation_id = "batchEvaluationId",
        .batch_evaluation_name = "batchEvaluationName",
        .created_at = "createdAt",
        .description = "description",
        .error_details = "errorDetails",
        .evaluation_results = "evaluationResults",
        .evaluators = "evaluators",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
