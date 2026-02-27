/// When included in a receipt rule, this action calls Amazon WorkMail and,
/// optionally,
/// publishes a notification to Amazon Simple Notification Service (Amazon SNS).
/// It usually isn't necessary to set this up
/// manually, because Amazon WorkMail adds the rule automatically during its
/// setup
/// procedure.
///
/// For information using a receipt rule to call Amazon WorkMail, see the
/// [Amazon SES
/// Developer
/// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email-action-workmail.html).
pub const WorkmailAction = struct {
    /// The Amazon Resource Name (ARN) of the Amazon WorkMail organization. Amazon
    /// WorkMail
    /// ARNs use the following format:
    ///
    /// `arn:aws:workmail:::organization/`
    ///
    /// You can find the ID of your organization by using the
    /// [ListOrganizations](https://docs.aws.amazon.com/workmail/latest/APIReference/API_ListOrganizations.html) operation in Amazon WorkMail. Amazon WorkMail
    /// organization IDs begin with "`m-`", followed by a string of alphanumeric
    /// characters.
    ///
    /// For information about Amazon WorkMail organizations, see the [Amazon
    /// WorkMail Administrator
    /// Guide](https://docs.aws.amazon.com/workmail/latest/adminguide/organizations_overview.html).
    organization_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the Amazon SNS topic to notify when the
    /// WorkMail action
    /// is called. You can find the ARN of a topic by using the
    /// [ListTopics](https://docs.aws.amazon.com/sns/latest/api/API_ListTopics.html)
    /// operation in
    /// Amazon SNS.
    ///
    /// For more information about Amazon SNS topics, see the [Amazon SNS Developer
    /// Guide](https://docs.aws.amazon.com/sns/latest/dg/CreateTopic.html).
    topic_arn: ?[]const u8,
};
