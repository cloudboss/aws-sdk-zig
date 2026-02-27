const CloudWatchOutputConfig = @import("cloud_watch_output_config.zig").CloudWatchOutputConfig;

/// The configuration that specifies where evaluation results should be written
/// for monitoring and analysis.
pub const OutputConfig = struct {
    /// The CloudWatch configuration for writing evaluation results to CloudWatch
    /// logs with embedded metric format.
    cloud_watch_config: CloudWatchOutputConfig,

    pub const json_field_names = .{
        .cloud_watch_config = "cloudWatchConfig",
    };
};
