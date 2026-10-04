const AIMlflowConfig = @import("ai_mlflow_config.zig").AIMlflowConfig;

/// The output configuration for an AI benchmark job.
pub const AIBenchmarkOutputConfig = struct {
    /// The MLflow tracking configuration for the job. If you don't specify this
    /// parameter, MLflow tracking is disabled.
    mlflow_config: ?AIMlflowConfig = null,

    /// The Amazon S3 URI where benchmark results are stored.
    s3_output_location: []const u8,

    pub const json_field_names = .{
        .mlflow_config = "MlflowConfig",
        .s3_output_location = "S3OutputLocation",
    };
};
