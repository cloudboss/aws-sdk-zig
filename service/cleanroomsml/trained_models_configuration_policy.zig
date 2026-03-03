const LogsConfigurationPolicy = @import("logs_configuration_policy.zig").LogsConfigurationPolicy;
const MetricsConfigurationPolicy = @import("metrics_configuration_policy.zig").MetricsConfigurationPolicy;
const TrainedModelArtifactMaxSize = @import("trained_model_artifact_max_size.zig").TrainedModelArtifactMaxSize;

/// The configuration policy for the trained models.
pub const TrainedModelsConfigurationPolicy = struct {
    /// The container for the logs of the trained model.
    container_logs: ?[]const LogsConfigurationPolicy = null,

    /// The container for the metrics of the trained model.
    container_metrics: ?MetricsConfigurationPolicy = null,

    /// The maximum size limit for trained model artifacts as defined in the
    /// configuration policy. This setting helps enforce consistent size limits
    /// across trained models in the collaboration.
    max_artifact_size: ?TrainedModelArtifactMaxSize = null,

    pub const json_field_names = .{
        .container_logs = "containerLogs",
        .container_metrics = "containerMetrics",
        .max_artifact_size = "maxArtifactSize",
    };
};
