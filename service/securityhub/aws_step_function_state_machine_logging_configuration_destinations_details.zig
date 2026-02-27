const AwsStepFunctionStateMachineLoggingConfigurationDestinationsCloudWatchLogsLogGroupDetails = @import("aws_step_function_state_machine_logging_configuration_destinations_cloud_watch_logs_log_group_details.zig").AwsStepFunctionStateMachineLoggingConfigurationDestinationsCloudWatchLogsLogGroupDetails;

/// An array of objects that describes where your execution history events will
/// be logged.
pub const AwsStepFunctionStateMachineLoggingConfigurationDestinationsDetails = struct {
    /// An object describing a CloudWatch Logs log group. For more information, see
    /// [
    /// Amazon Web
    /// Services::Logs::LogGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-logs-loggroup.html) in the *CloudFormation User Guide*.
    cloud_watch_logs_log_group: ?AwsStepFunctionStateMachineLoggingConfigurationDestinationsCloudWatchLogsLogGroupDetails,

    pub const json_field_names = .{
        .cloud_watch_logs_log_group = "CloudWatchLogsLogGroup",
    };
};
