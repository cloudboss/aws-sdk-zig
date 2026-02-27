const CustomEmailSenderLambdaVersionType = @import("custom_email_sender_lambda_version_type.zig").CustomEmailSenderLambdaVersionType;

/// The properties of a custom email sender Lambda trigger.
pub const CustomEmailLambdaVersionConfigType = struct {
    /// The Amazon Resource Name (ARN) of the function that you want to assign to
    /// your Lambda trigger.
    lambda_arn: []const u8,

    /// The user pool trigger version of the request that Amazon Cognito sends to
    /// your Lambda function. Higher-numbered versions add fields that support new
    /// features.
    ///
    /// You must use a `LambdaVersion` of `V1_0` with a custom sender
    /// function.
    lambda_version: CustomEmailSenderLambdaVersionType,

    pub const json_field_names = .{
        .lambda_arn = "LambdaArn",
        .lambda_version = "LambdaVersion",
    };
};
