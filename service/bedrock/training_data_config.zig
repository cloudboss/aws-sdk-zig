const InvocationLogsConfig = @import("invocation_logs_config.zig").InvocationLogsConfig;

/// S3 Location of the training data.
pub const TrainingDataConfig = struct {
    /// Settings for using invocation logs to customize a model.
    invocation_logs_config: ?InvocationLogsConfig,

    /// The S3 URI where the training data is stored.
    s_3_uri: ?[]const u8,

    pub const json_field_names = .{
        .invocation_logs_config = "invocationLogsConfig",
        .s_3_uri = "s3Uri",
    };
};
