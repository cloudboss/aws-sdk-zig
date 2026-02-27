const LambdaAction = @import("lambda_action.zig").LambdaAction;

/// Specifies an AWS Lambda function to manage alarm notifications.
/// You can create one or use the [AWS Lambda function provided by AWS IoT
/// Events](https://docs.aws.amazon.com/iotevents/latest/developerguide/lambda-support.html).
pub const NotificationTargetActions = struct {
    lambda_action: ?LambdaAction,

    pub const json_field_names = .{
        .lambda_action = "lambdaAction",
    };
};
