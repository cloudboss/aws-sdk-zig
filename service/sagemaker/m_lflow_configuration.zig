/// The MLflow configuration.
pub const MLflowConfiguration = struct {
    /// The name of the MLflow configuration.
    mlflow_experiment_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of MLflow configuration resource.
    mlflow_resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .mlflow_experiment_name = "MlflowExperimentName",
        .mlflow_resource_arn = "MlflowResourceArn",
    };
};
