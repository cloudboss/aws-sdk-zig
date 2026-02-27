/// The collection of license usage records.
pub const AdminAppLicenseUsageRecord = struct {
    /// The billing period for the license usage record.
    billing_period: []const u8,

    /// The type of license (for example, Microsoft Office).
    license_type: []const u8,

    /// The account ID of the owner of the license.
    owner_aws_account_id: []const u8,

    /// The date and time when the license was first used.
    subscription_first_used_date: i64,

    /// The date and time when the license was last used.
    subscription_last_used_date: i64,

    /// The ARN of the user who used the license-included application.
    user_arn: []const u8,

    /// The ID of the user who used the license-included application.
    user_id: []const u8,

    pub const json_field_names = .{
        .billing_period = "BillingPeriod",
        .license_type = "LicenseType",
        .owner_aws_account_id = "OwnerAWSAccountId",
        .subscription_first_used_date = "SubscriptionFirstUsedDate",
        .subscription_last_used_date = "SubscriptionLastUsedDate",
        .user_arn = "UserArn",
        .user_id = "UserId",
    };
};
