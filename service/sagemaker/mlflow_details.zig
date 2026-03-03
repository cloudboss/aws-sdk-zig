/// The MLflow details of this job.
pub const MlflowDetails = struct {
    /// The MLflow experiment ID used for this job.
    mlflow_experiment_id: ?[]const u8 = null,

    /// The MLflow run ID used for this job.
    mlflow_run_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .mlflow_experiment_id = "MlflowExperimentId",
        .mlflow_run_id = "MlflowRunId",
    };
};
