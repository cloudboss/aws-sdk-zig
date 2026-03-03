const aws = @import("aws");

const AccountRecoverySettingType = @import("account_recovery_setting_type.zig").AccountRecoverySettingType;
const AdminCreateUserConfigType = @import("admin_create_user_config_type.zig").AdminCreateUserConfigType;
const AliasAttributeType = @import("alias_attribute_type.zig").AliasAttributeType;
const VerifiedAttributeType = @import("verified_attribute_type.zig").VerifiedAttributeType;
const DeletionProtectionType = @import("deletion_protection_type.zig").DeletionProtectionType;
const DeviceConfigurationType = @import("device_configuration_type.zig").DeviceConfigurationType;
const EmailConfigurationType = @import("email_configuration_type.zig").EmailConfigurationType;
const LambdaConfigType = @import("lambda_config_type.zig").LambdaConfigType;
const UserPoolMfaType = @import("user_pool_mfa_type.zig").UserPoolMfaType;
const UserPoolPolicyType = @import("user_pool_policy_type.zig").UserPoolPolicyType;
const SchemaAttributeType = @import("schema_attribute_type.zig").SchemaAttributeType;
const SmsConfigurationType = @import("sms_configuration_type.zig").SmsConfigurationType;
const StatusType = @import("status_type.zig").StatusType;
const UserAttributeUpdateSettingsType = @import("user_attribute_update_settings_type.zig").UserAttributeUpdateSettingsType;
const UsernameAttributeType = @import("username_attribute_type.zig").UsernameAttributeType;
const UsernameConfigurationType = @import("username_configuration_type.zig").UsernameConfigurationType;
const UserPoolAddOnsType = @import("user_pool_add_ons_type.zig").UserPoolAddOnsType;
const UserPoolTierType = @import("user_pool_tier_type.zig").UserPoolTierType;
const VerificationMessageTemplateType = @import("verification_message_template_type.zig").VerificationMessageTemplateType;

/// The configuration of a user pool.
pub const UserPoolType = struct {
    /// The available verified method a user can use to recover their password when
    /// they call
    /// `ForgotPassword`. You can use this setting to define a preferred method
    /// when a user has more than one method available. With this setting, SMS
    /// doesn't qualify
    /// for a valid password recovery mechanism if the user also has SMS
    /// multi-factor
    /// authentication (MFA) activated. In the absence of this setting, Amazon
    /// Cognito uses the legacy
    /// behavior to determine the recovery method where SMS is preferred through
    /// email.
    account_recovery_setting: ?AccountRecoverySettingType = null,

    /// The configuration for `AdminCreateUser` requests.
    admin_create_user_config: ?AdminCreateUserConfigType = null,

    /// Attributes supported as an alias for this user pool. An alias is an
    /// attribute that
    /// users can enter as an alternative username. Possible values:
    /// **phone_number**, **email**, or **preferred_username**.
    alias_attributes: ?[]const AliasAttributeType = null,

    /// The Amazon Resource Name (ARN) of the user pool.
    arn: ?[]const u8 = null,

    /// The attributes that are auto-verified in a user pool.
    auto_verified_attributes: ?[]const VerifiedAttributeType = null,

    /// The date and time when the item was created. Amazon Cognito returns this
    /// timestamp in UNIX epoch time format. Your SDK might render the output in a
    /// human-readable format like ISO 8601 or a Java `Date` object.
    creation_date: ?i64 = null,

    /// A custom domain name that you provide to Amazon Cognito. This parameter
    /// applies only if you use
    /// a custom domain to host the sign-up and sign-in pages for your application.
    /// An example
    /// of a custom domain name might be `auth.example.com`.
    ///
    /// For more information about adding a custom domain to your user pool, see
    /// [Using Your Own Domain for the Hosted
    /// UI](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-add-custom-domain.html).
    custom_domain: ?[]const u8 = null,

    /// When active, `DeletionProtection` prevents accidental deletion of your user
    /// pool. Before you can delete a user pool that you have protected against
    /// deletion, you
    /// must deactivate this feature.
    ///
    /// When you try to delete a protected user pool in a `DeleteUserPool` API
    /// request,
    /// Amazon Cognito returns an `InvalidParameterException` error. To delete a
    /// protected user pool,
    /// send a new `DeleteUserPool` request after you deactivate deletion protection
    /// in an
    /// `UpdateUserPool` API request.
    deletion_protection: ?DeletionProtectionType = null,

    /// The device-remembering configuration for a user pool. A null value indicates
    /// that you
    /// have deactivated device remembering in your user pool.
    ///
    /// When you provide a value for any `DeviceConfiguration` field, you
    /// activate the Amazon Cognito device-remembering feature.
    device_configuration: ?DeviceConfigurationType = null,

    /// The domain prefix, if the user pool has a domain associated with it.
    domain: ?[]const u8 = null,

    /// The email configuration of your user pool. The email configuration type sets
    /// your
    /// preferred sending method, Amazon Web Services Region, and sender for
    /// messages from your user
    /// pool.
    email_configuration: ?EmailConfigurationType = null,

    /// Deprecated. Review error codes from API requests with
    /// `EventSource:cognito-idp.amazonaws.com` in CloudTrail for
    /// information about problems with user pool email configuration.
    email_configuration_failure: ?[]const u8 = null,

    /// This parameter is no longer used.
    email_verification_message: ?[]const u8 = null,

    /// This parameter is no longer used.
    email_verification_subject: ?[]const u8 = null,

    /// A number estimating the size of the user pool.
    estimated_number_of_users: i32 = 0,

    /// The ID of the user pool.
    id: ?[]const u8 = null,

    /// A collection of user pool Lambda triggers. Amazon Cognito invokes triggers
    /// at several possible
    /// stages of user pool operations. Triggers can modify the outcome of the
    /// operations that
    /// invoked them.
    lambda_config: ?LambdaConfigType = null,

    /// The date and time when the item was modified. Amazon Cognito returns this
    /// timestamp in UNIX epoch time format. Your SDK might render the output in a
    /// human-readable format like ISO 8601 or a Java `Date` object.
    last_modified_date: ?i64 = null,

    /// Can be one of the following values:
    ///
    /// * `OFF` - MFA tokens aren't required and can't be specified during user
    /// registration.
    ///
    /// * `ON` - MFA tokens are required for all user registrations. You can
    /// only specify required when you're initially creating a user pool.
    ///
    /// * `OPTIONAL` - Users have the option when registering to create an MFA
    /// token.
    mfa_configuration: ?UserPoolMfaType = null,

    /// The name of the user pool.
    name: ?[]const u8 = null,

    /// A list of user pool policies. Contains the policy that sets
    /// password-complexity
    /// requirements.
    policies: ?UserPoolPolicyType = null,

    /// A list of the user attributes and their properties in your user pool. The
    /// attribute
    /// schema contains standard attributes, custom attributes with a `custom:`
    /// prefix, and developer attributes with a `dev:` prefix. For more information,
    /// see [User pool
    /// attributes](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-attributes.html).
    ///
    /// Developer-only attributes are a legacy feature of user pools, and are
    /// read-only to all
    /// app clients. You can create and update developer-only attributes only with
    /// IAM-authenticated API operations. Use app client read/write permissions
    /// instead.
    schema_attributes: ?[]const SchemaAttributeType = null,

    /// The contents of the SMS authentication message.
    sms_authentication_message: ?[]const u8 = null,

    /// User pool configuration for delivery of SMS messages with Amazon Simple
    /// Notification Service. To send SMS
    /// messages with Amazon SNS in the Amazon Web Services Region that you want,
    /// the Amazon Cognito user pool uses an
    /// Identity and Access Management (IAM) role in your Amazon Web Services
    /// account.
    sms_configuration: ?SmsConfigurationType = null,

    /// The reason why the SMS configuration can't send the messages to your users.
    ///
    /// This message might include comma-separated values to describe why your SMS
    /// configuration can't send messages to user pool end users.
    ///
    /// **InvalidSmsRoleAccessPolicyException**
    ///
    /// The Identity and Access Management role that Amazon Cognito uses to send SMS
    /// messages isn't properly
    /// configured. For more information, see
    /// [SmsConfigurationType](https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_SmsConfigurationType.html).
    ///
    /// **SNSSandbox**
    ///
    /// The Amazon Web Services account is in the SNS SMS Sandbox and messages will
    /// only reach verified end users. This parameter won’t get populated with
    /// SNSSandbox if the user creating the user pool doesn’t have SNS permissions.
    /// To learn how to move your Amazon Web Services account out of the sandbox,
    /// see
    /// [Moving out
    /// of the SMS
    /// sandbox](https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox-moving-to-production.html).
    sms_configuration_failure: ?[]const u8 = null,

    /// This parameter is no longer used.
    sms_verification_message: ?[]const u8 = null,

    /// This parameter is no longer used.
    status: ?StatusType = null,

    /// The settings for updates to user attributes. These settings include the
    /// property `AttributesRequireVerificationBeforeUpdate`,
    /// a user-pool setting that tells Amazon Cognito how to handle changes to the
    /// value of your users' email address and phone number attributes. For
    /// more information, see [
    /// Verifying updates to email addresses and phone
    /// numbers](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-email-phone-verification.html#user-pool-settings-verifications-verify-attribute-updates).
    user_attribute_update_settings: ?UserAttributeUpdateSettingsType = null,

    /// Specifies whether a user can use an email address or phone number as a
    /// username when
    /// they sign up.
    username_attributes: ?[]const UsernameAttributeType = null,

    /// Case sensitivity of the username input for the selected sign-in option. When
    /// case
    /// sensitivity is set to `False` (case insensitive), users can sign in with any
    /// combination of capital and lowercase letters. For example, `username`,
    /// `USERNAME`, or `UserName`, or for email,
    /// `email@example.com` or `EMaiL@eXamplE.Com`. For most use
    /// cases, set case sensitivity to `False` (case insensitive) as a best
    /// practice.
    /// When usernames and email addresses are case insensitive, Amazon Cognito
    /// treats any variation in
    /// case as the same user, and prevents a case variation from being assigned to
    /// the same
    /// attribute for a different user.
    username_configuration: ?UsernameConfigurationType = null,

    /// Contains settings for activation of threat protection, including the
    /// operating
    /// mode and additional authentication types. To log user security information
    /// but take
    /// no action, set to `AUDIT`. To configure automatic security responses to
    /// potentially unwanted traffic to your user pool, set to `ENFORCED`.
    ///
    /// For more information, see [Adding advanced security to a user
    /// pool](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pool-settings-advanced-security.html). To activate this setting, your user pool must be on the [
    /// Plus
    /// tier](https://docs.aws.amazon.com/cognito/latest/developerguide/feature-plans-features-plus.html).
    user_pool_add_ons: ?UserPoolAddOnsType = null,

    /// The tags that are assigned to the user pool. A tag is a label that you can
    /// apply to
    /// user pools to categorize and manage them in different ways, such as by
    /// purpose, owner,
    /// environment, or other criteria.
    user_pool_tags: ?[]const aws.map.StringMapEntry = null,

    /// The user pool [feature
    /// plan](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-sign-in-feature-plans.html), or tier. This parameter determines the
    /// eligibility of the user pool for features like managed login, access-token
    /// customization, and threat protection. Defaults to `ESSENTIALS`.
    user_pool_tier: ?UserPoolTierType = null,

    /// The template for the verification message that your user pool delivers to
    /// users who
    /// set an email address or phone number attribute.
    verification_message_template: ?VerificationMessageTemplateType = null,

    pub const json_field_names = .{
        .account_recovery_setting = "AccountRecoverySetting",
        .admin_create_user_config = "AdminCreateUserConfig",
        .alias_attributes = "AliasAttributes",
        .arn = "Arn",
        .auto_verified_attributes = "AutoVerifiedAttributes",
        .creation_date = "CreationDate",
        .custom_domain = "CustomDomain",
        .deletion_protection = "DeletionProtection",
        .device_configuration = "DeviceConfiguration",
        .domain = "Domain",
        .email_configuration = "EmailConfiguration",
        .email_configuration_failure = "EmailConfigurationFailure",
        .email_verification_message = "EmailVerificationMessage",
        .email_verification_subject = "EmailVerificationSubject",
        .estimated_number_of_users = "EstimatedNumberOfUsers",
        .id = "Id",
        .lambda_config = "LambdaConfig",
        .last_modified_date = "LastModifiedDate",
        .mfa_configuration = "MfaConfiguration",
        .name = "Name",
        .policies = "Policies",
        .schema_attributes = "SchemaAttributes",
        .sms_authentication_message = "SmsAuthenticationMessage",
        .sms_configuration = "SmsConfiguration",
        .sms_configuration_failure = "SmsConfigurationFailure",
        .sms_verification_message = "SmsVerificationMessage",
        .status = "Status",
        .user_attribute_update_settings = "UserAttributeUpdateSettings",
        .username_attributes = "UsernameAttributes",
        .username_configuration = "UsernameConfiguration",
        .user_pool_add_ons = "UserPoolAddOns",
        .user_pool_tags = "UserPoolTags",
        .user_pool_tier = "UserPoolTier",
        .verification_message_template = "VerificationMessageTemplate",
    };
};
