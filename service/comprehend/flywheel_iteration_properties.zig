const FlywheelModelEvaluationMetrics = @import("flywheel_model_evaluation_metrics.zig").FlywheelModelEvaluationMetrics;
const FlywheelIterationStatus = @import("flywheel_iteration_status.zig").FlywheelIterationStatus;

/// The configuration properties of a flywheel iteration.
pub const FlywheelIterationProperties = struct {
    /// The creation start time of the flywheel iteration.
    creation_time: ?i64 = null,

    /// The completion time of this flywheel iteration.
    end_time: ?i64 = null,

    /// The ARN of the evaluated model associated with this flywheel iteration.
    evaluated_model_arn: ?[]const u8 = null,

    evaluated_model_metrics: ?FlywheelModelEvaluationMetrics = null,

    evaluation_manifest_s3_prefix: ?[]const u8 = null,

    flywheel_arn: ?[]const u8 = null,

    flywheel_iteration_id: ?[]const u8 = null,

    /// A description of the status of the flywheel iteration.
    message: ?[]const u8 = null,

    /// The status of the flywheel iteration.
    status: ?FlywheelIterationStatus = null,

    /// The ARN of the trained model associated with this flywheel iteration.
    trained_model_arn: ?[]const u8 = null,

    /// The metrics associated with the trained model.
    trained_model_metrics: ?FlywheelModelEvaluationMetrics = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .end_time = "EndTime",
        .evaluated_model_arn = "EvaluatedModelArn",
        .evaluated_model_metrics = "EvaluatedModelMetrics",
        .evaluation_manifest_s3_prefix = "EvaluationManifestS3Prefix",
        .flywheel_arn = "FlywheelArn",
        .flywheel_iteration_id = "FlywheelIterationId",
        .message = "Message",
        .status = "Status",
        .trained_model_arn = "TrainedModelArn",
        .trained_model_metrics = "TrainedModelMetrics",
    };
};
