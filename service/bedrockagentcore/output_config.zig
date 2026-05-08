const CloudWatchOutputConfig = @import("cloud_watch_output_config.zig").CloudWatchOutputConfig;

/// Output destination configuration
pub const OutputConfig = union(enum) {
    /// The CloudWatch Logs configuration for writing evaluation results.
    cloud_watch_config: ?CloudWatchOutputConfig,

    pub const json_field_names = .{
        .cloud_watch_config = "cloudWatchConfig",
    };
};
