/// Contains the account details of the partner who received the Engagement
/// Invitation, including the AWS account ID and company name.
pub const AccountReceiver = struct {
    /// Represents the alias of the partner account receiving the Engagement
    /// Invitation, making it easier to identify and track the recipient in reports
    /// or logs.
    alias: ?[]const u8 = null,

    /// Indicates the AWS account ID of the partner who received the Engagement
    /// Invitation. This is a unique identifier for managing engagements with
    /// specific AWS accounts.
    aws_account_id: []const u8,

    pub const json_field_names = .{
        .alias = "Alias",
        .aws_account_id = "AwsAccountId",
    };
};
