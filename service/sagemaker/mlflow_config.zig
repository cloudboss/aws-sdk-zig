/// The MLflow configuration using SageMaker managed MLflow.
pub const MlflowConfig = struct {
    /// The MLflow experiment name used for this job.
    mlflow_experiment_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the MLflow resource.
    mlflow_resource_arn: []const u8,

    /// The MLflow run name used for this job.
    mlflow_run_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .mlflow_experiment_name = "MlflowExperimentName",
        .mlflow_resource_arn = "MlflowResourceArn",
        .mlflow_run_name = "MlflowRunName",
    };
};
