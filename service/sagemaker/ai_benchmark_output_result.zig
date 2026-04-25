const AICloudWatchLogs = @import("ai_cloud_watch_logs.zig").AICloudWatchLogs;

/// The output result of an AI benchmark job, including the Amazon S3 location
/// and CloudWatch log information.
pub const AIBenchmarkOutputResult = struct {
    /// The CloudWatch log information for the benchmark job.
    cloud_watch_logs: ?[]const AICloudWatchLogs = null,

    /// The Amazon S3 URI where benchmark results are stored.
    s3_output_location: []const u8,

    pub const json_field_names = .{
        .cloud_watch_logs = "CloudWatchLogs",
        .s3_output_location = "S3OutputLocation",
    };
};
