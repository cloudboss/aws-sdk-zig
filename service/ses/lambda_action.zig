const InvocationType = @import("invocation_type.zig").InvocationType;

/// When included in a receipt rule, this action calls an Amazon Web Services
/// Lambda function and,
/// optionally, publishes a notification to Amazon Simple Notification Service
/// (Amazon SNS).
///
/// To enable Amazon SES to call your Amazon Web Services Lambda function or to
/// publish to an Amazon SNS topic of
/// another account, Amazon SES must have permission to access those resources.
/// For information
/// about giving permissions, see the [Amazon SES Developer
/// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email-permissions.html).
///
/// For information about using Amazon Web Services Lambda actions in receipt
/// rules, see the [Amazon SES
/// Developer
/// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email-action-lambda.html).
pub const LambdaAction = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Web Services Lambda function.
    /// An example of an Amazon Web Services Lambda
    /// function ARN is `arn:aws:lambda:us-west-2:account-id:function:MyFunction`.
    /// For more information about Amazon Web Services Lambda, see the [Amazon Web
    /// Services Lambda Developer
    /// Guide](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html).
    function_arn: []const u8,

    /// The invocation type of the Amazon Web Services Lambda function. An
    /// invocation type of
    /// `RequestResponse` means that the execution of the function immediately
    /// results in a response, and a value of `Event` means that the function is
    /// invoked asynchronously. The default value is `Event`. For information about
    /// Amazon Web Services Lambda invocation types, see the [Amazon Web Services
    /// Lambda Developer
    /// Guide](https://docs.aws.amazon.com/lambda/latest/dg/API_Invoke.html).
    ///
    /// There is a 30-second timeout on `RequestResponse` invocations. You
    /// should use `Event` invocation in most cases. Use
    /// `RequestResponse` only to make a mail flow decision, such as whether
    /// to stop the receipt rule or the receipt rule set.
    invocation_type: ?InvocationType = null,

    /// The Amazon Resource Name (ARN) of the Amazon SNS topic to notify when the
    /// Lambda action is
    /// executed. You can find the ARN of a topic by using the
    /// [ListTopics](https://docs.aws.amazon.com/sns/latest/api/API_ListTopics.html)
    /// operation in
    /// Amazon SNS.
    ///
    /// For more information about Amazon SNS topics, see the [Amazon SNS Developer
    /// Guide](https://docs.aws.amazon.com/sns/latest/dg/CreateTopic.html).
    topic_arn: ?[]const u8 = null,
};
