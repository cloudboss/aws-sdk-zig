/// The MLflow tracking configuration for logging metrics and parameters to a
/// SageMaker managed MLflow tracking server.
pub const AIMlflowConfig = struct {
    /// The MLflow experiment name used for tracking.
    mlflow_experiment_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the SageMaker managed MLflow resource.
    mlflow_resource_arn: []const u8,

    /// The MLflow run name used for tracking.
    mlflow_run_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .mlflow_experiment_name = "MlflowExperimentName",
        .mlflow_resource_arn = "MlflowResourceArn",
        .mlflow_run_name = "MlflowRunName",
    };
};
