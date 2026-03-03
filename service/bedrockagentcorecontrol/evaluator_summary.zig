const EvaluatorType = @import("evaluator_type.zig").EvaluatorType;
const EvaluatorLevel = @import("evaluator_level.zig").EvaluatorLevel;
const EvaluatorStatus = @import("evaluator_status.zig").EvaluatorStatus;

/// The summary information about an evaluator, including basic metadata and
/// status information.
pub const EvaluatorSummary = struct {
    /// The timestamp when the evaluator was created.
    created_at: i64,

    /// The description of the evaluator.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the evaluator.
    evaluator_arn: []const u8,

    /// The unique identifier of the evaluator.
    evaluator_id: []const u8,

    /// The name of the evaluator.
    evaluator_name: []const u8,

    /// The type of evaluator, indicating whether it is a built-in evaluator
    /// provided by the service or a custom evaluator created by the user.
    evaluator_type: EvaluatorType,

    /// The evaluation level (`TOOL_CALL`, `TRACE`, or `SESSION`) that determines
    /// the scope of evaluation.
    level: ?EvaluatorLevel = null,

    /// Whether the evaluator is locked for modification due to being referenced by
    /// active online evaluation configurations.
    locked_for_modification: ?bool = null,

    /// The current status of the evaluator.
    status: EvaluatorStatus,

    /// The timestamp when the evaluator was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .evaluator_arn = "evaluatorArn",
        .evaluator_id = "evaluatorId",
        .evaluator_name = "evaluatorName",
        .evaluator_type = "evaluatorType",
        .level = "level",
        .locked_for_modification = "lockedForModification",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
