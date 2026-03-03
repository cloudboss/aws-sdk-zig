/// User pool configuration for delivery of SMS messages with Amazon Simple
/// Notification Service. To send SMS
/// messages with Amazon SNS in the Amazon Web Services Region that you want,
/// the Amazon Cognito user pool uses an
/// Identity and Access Management (IAM) role in your Amazon Web Services
/// account.
pub const SmsConfigurationType = struct {
    /// The external ID provides additional security for your IAM role. You can use
    /// an
    /// `ExternalId` with the IAM role that you use with Amazon SNS to send SMS
    /// messages for your user pool. If you provide an `ExternalId`, your Amazon
    /// Cognito user
    /// pool includes it in the request to assume your IAM role. You can configure
    /// the role
    /// trust policy to require that Amazon Cognito, and any principal, provide the
    /// `ExternalID`. If you use the Amazon Cognito Management Console to create a
    /// role
    /// for SMS multi-factor authentication (MFA), Amazon Cognito creates a role
    /// with the required
    /// permissions and a trust policy that demonstrates use of the
    /// `ExternalId`.
    ///
    /// For more information about the `ExternalId` of a role, see [How to use an
    /// external ID when granting access to your Amazon Web Services resources to a
    /// third
    /// party](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-user_externalid.html).
    external_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Amazon SNS caller. This is the ARN of
    /// the IAM role
    /// in your Amazon Web Services account that Amazon Cognito will use to send SMS
    /// messages. SMS
    /// messages are subject to a [spending
    /// limit](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-email-phone-verification.html).
    sns_caller_arn: []const u8,

    /// The Amazon Web Services Region to use with Amazon SNS integration. You can
    /// choose the same Region as your
    /// user pool, or a supported **Legacy Amazon SNS alternate
    /// Region**.
    ///
    /// Amazon Cognito resources in the Asia Pacific (Seoul) Amazon Web Services
    /// Region must use your Amazon SNS
    /// configuration in the Asia Pacific (Tokyo) Region. For more information, see
    /// [SMS message settings for Amazon Cognito user
    /// pools](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-sms-settings.html).
    sns_region: ?[]const u8 = null,

    pub const json_field_names = .{
        .external_id = "ExternalId",
        .sns_caller_arn = "SnsCallerArn",
        .sns_region = "SnsRegion",
    };
};
