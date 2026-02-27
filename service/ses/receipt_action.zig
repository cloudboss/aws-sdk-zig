const AddHeaderAction = @import("add_header_action.zig").AddHeaderAction;
const BounceAction = @import("bounce_action.zig").BounceAction;
const ConnectAction = @import("connect_action.zig").ConnectAction;
const LambdaAction = @import("lambda_action.zig").LambdaAction;
const S3Action = @import("s3_action.zig").S3Action;
const SNSAction = @import("sns_action.zig").SNSAction;
const StopAction = @import("stop_action.zig").StopAction;
const WorkmailAction = @import("workmail_action.zig").WorkmailAction;

/// An action that Amazon SES can take when it receives an email on behalf of
/// one or more email
/// addresses or domains that you own. An instance of this data type can
/// represent only one
/// action.
///
/// For information about setting up receipt rules, see the [Amazon SES
/// Developer
/// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email-receipt-rules-console-walkthrough.html).
pub const ReceiptAction = struct {
    /// Adds a header to the received email.
    add_header_action: ?AddHeaderAction,

    /// Rejects the received email by returning a bounce response to the sender and,
    /// optionally, publishes a notification to Amazon Simple Notification Service
    /// (Amazon SNS).
    bounce_action: ?BounceAction,

    /// Parses the received message and starts an email contact in Amazon Connect on
    /// your behalf.
    connect_action: ?ConnectAction,

    /// Calls an Amazon Web Services Lambda function, and optionally, publishes a
    /// notification to Amazon SNS.
    lambda_action: ?LambdaAction,

    /// Saves the received message to an Amazon Simple Storage Service (Amazon S3)
    /// bucket and, optionally, publishes a
    /// notification to Amazon SNS.
    s3_action: ?S3Action,

    /// Publishes the email content within a notification to Amazon SNS.
    sns_action: ?SNSAction,

    /// Terminates the evaluation of the receipt rule set and optionally publishes a
    /// notification to Amazon SNS.
    stop_action: ?StopAction,

    /// Calls Amazon WorkMail and, optionally, publishes a notification to Amazon
    /// Amazon SNS.
    workmail_action: ?WorkmailAction,
};
