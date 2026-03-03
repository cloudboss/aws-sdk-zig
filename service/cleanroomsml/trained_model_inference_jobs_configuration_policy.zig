const LogsConfigurationPolicy = @import("logs_configuration_policy.zig").LogsConfigurationPolicy;
const TrainedModelInferenceMaxOutputSize = @import("trained_model_inference_max_output_size.zig").TrainedModelInferenceMaxOutputSize;

/// Provides configuration information for the trained model inference job.
pub const TrainedModelInferenceJobsConfigurationPolicy = struct {
    /// The logs container for the trained model inference job.
    container_logs: ?[]const LogsConfigurationPolicy = null,

    /// The maximum allowed size of the output of the trained model inference job.
    max_output_size: ?TrainedModelInferenceMaxOutputSize = null,

    pub const json_field_names = .{
        .container_logs = "containerLogs",
        .max_output_size = "maxOutputSize",
    };
};
