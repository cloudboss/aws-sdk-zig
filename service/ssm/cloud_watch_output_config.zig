/// Configuration options for sending command output to Amazon CloudWatch Logs.
pub const CloudWatchOutputConfig = struct {
    /// The name of the CloudWatch Logs log group where you want to send command
    /// output. If you
    /// don't specify a group name, Amazon Web Services Systems Manager
    /// automatically creates a log group for you. The log group
    /// uses the following naming format:
    ///
    /// `aws/ssm/*SystemsManagerDocumentName*
    /// `
    cloud_watch_log_group_name: ?[]const u8,

    /// Enables Systems Manager to send command output to CloudWatch Logs.
    cloud_watch_output_enabled: ?bool,

    pub const json_field_names = .{
        .cloud_watch_log_group_name = "CloudWatchLogGroupName",
        .cloud_watch_output_enabled = "CloudWatchOutputEnabled",
    };
};
