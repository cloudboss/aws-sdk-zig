/// An object describing a CloudWatch log group. For more information, see
/// [
/// Amazon Web
/// Services::Logs::LogGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-logs-loggroup.html) in the *CloudFormation User Guide*.
pub const AwsStepFunctionStateMachineLoggingConfigurationDestinationsCloudWatchLogsLogGroupDetails = struct {
    /// The ARN (ends with `:*`) of the CloudWatch Logs log group to which you want
    /// your logs emitted.
    log_group_arn: ?[]const u8,

    pub const json_field_names = .{
        .log_group_arn = "LogGroupArn",
    };
};
