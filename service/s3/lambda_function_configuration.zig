const Event = @import("event.zig").Event;
const NotificationConfigurationFilter = @import("notification_configuration_filter.zig").NotificationConfigurationFilter;

/// A container for specifying the configuration for Lambda notifications.
pub const LambdaFunctionConfiguration = struct {
    /// The Amazon S3 bucket event for which to invoke the Lambda function. For more
    /// information, see [Supported Event
    /// Types](https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html) in
    /// the *Amazon S3 User Guide*.
    events: []const Event,

    filter: ?NotificationConfigurationFilter,

    id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the Lambda function that Amazon S3 invokes
    /// when the specified event
    /// type occurs.
    lambda_function_arn: []const u8,
};
