/// When included in a receipt rule, this action parses the received message and
/// starts an email contact in Amazon Connect on your behalf.
///
/// When you receive emails, the maximum email size (including headers) is 40
/// MB.
/// Additionally, emails may only have up to 10 attachments.
/// Emails larger than 40 MB or with more than 10 attachments will be bounced.
///
/// We recommend that you configure this action via Amazon Connect.
pub const ConnectAction = struct {
    /// The Amazon Resource Name (ARN) of the IAM role to be used by Amazon Simple
    /// Email Service while starting email contacts
    /// to the Amazon Connect instance. This role should have permission to invoke
    /// `connect:StartEmailContact`
    /// for the given Amazon Connect instance.
    iam_role_arn: []const u8,

    /// The Amazon Resource Name (ARN) for the Amazon Connect instance that Amazon
    /// SES integrates with for starting
    /// email contacts.
    ///
    /// For more information about Amazon Connect instances, see the [Amazon Connect
    /// Administrator
    /// Guide](https://docs.aws.amazon.com/connect/latest/adminguide/amazon-connect-instances.html)
    instance_arn: []const u8,
};
