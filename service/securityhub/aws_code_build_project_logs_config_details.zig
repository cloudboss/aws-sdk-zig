const AwsCodeBuildProjectLogsConfigCloudWatchLogsDetails = @import("aws_code_build_project_logs_config_cloud_watch_logs_details.zig").AwsCodeBuildProjectLogsConfigCloudWatchLogsDetails;
const AwsCodeBuildProjectLogsConfigS3LogsDetails = @import("aws_code_build_project_logs_config_s3_logs_details.zig").AwsCodeBuildProjectLogsConfigS3LogsDetails;

/// Information about logs for the build project.
pub const AwsCodeBuildProjectLogsConfigDetails = struct {
    /// Information about CloudWatch Logs for the build project.
    cloud_watch_logs: ?AwsCodeBuildProjectLogsConfigCloudWatchLogsDetails,

    /// Information about logs built to an S3 bucket for a build project.
    s3_logs: ?AwsCodeBuildProjectLogsConfigS3LogsDetails,

    pub const json_field_names = .{
        .cloud_watch_logs = "CloudWatchLogs",
        .s3_logs = "S3Logs",
    };
};
