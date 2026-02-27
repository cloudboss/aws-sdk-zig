/// Information about CloudWatch Logs for the build project.
pub const AwsCodeBuildProjectLogsConfigCloudWatchLogsDetails = struct {
    /// The group name of the logs in CloudWatch Logs.
    group_name: ?[]const u8,

    /// The current status of the logs in CloudWatch Logs for a build project.
    status: ?[]const u8,

    /// The prefix of the stream name of the CloudWatch Logs.
    stream_name: ?[]const u8,

    pub const json_field_names = .{
        .group_name = "GroupName",
        .status = "Status",
        .stream_name = "StreamName",
    };
};
