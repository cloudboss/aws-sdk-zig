/// The configuration that Amazon Cognito uses to send SMS messages through
/// Amazon Web Services End User
/// Messaging SMS. Provide this structure in the `EumsSms` member of
/// `SmsConfigurationType` to use Amazon Web Services End User Messaging SMS
/// instead of
/// Amazon SNS.
pub const EumsSmsConfigurationType = struct {
    /// The ARN of the IAM role that Amazon Cognito assumes to send SMS messages
    /// through Amazon Web Services
    /// End User Messaging SMS. The role must grant permission to call the
    /// `sms-voice:SendTextMessage` operation.
    caller_arn: []const u8,

    /// The name of the Amazon Web Services End User Messaging SMS configuration set
    /// that Amazon Cognito
    /// applies to messages, for logging and event destinations. If you omit this
    /// member,
    /// Amazon Cognito sends messages without applying a configuration set.
    configuration_set_name: ?[]const u8 = null,

    /// The external ID that Amazon Cognito includes when it assumes the `CallerArn`
    /// role.
    /// Use this value as a condition in the role trust policy to prevent the
    /// confused deputy
    /// problem.
    external_id: ?[]const u8 = null,

    /// The principal entity ID required by India's Distributed Ledger Technology
    /// (DLT) regulations for SMS messages.
    in_entity_id: ?[]const u8 = null,

    /// The registered template ID for the message template required by India's DLT
    /// regulations for SMS messages.
    in_template_id: ?[]const u8 = null,

    /// The origination identity that Amazon Web Services End User Messaging SMS
    /// uses to send messages to your users. This value can be one of the following:
    ///
    /// * A phone number – A long code, toll-free number, or short code
    /// that is assigned to your account.
    ///
    /// * A sender ID – An alphabetic name that identifies the message sender
    /// in supported countries.
    ///
    /// * A phone pool – A group of phone numbers that Amazon Web Services End User
    /// Messaging SMS selects from when it sends messages.
    ///
    /// You can provide an E.164 phone number or the ARN of the phone number, sender
    /// ID, or
    /// phone pool. Amazon Web Services End User Messaging SMS evaluates IAM
    /// authorization with the value
    /// that you provide. If the permissions policy of your `CallerArn` role scopes
    /// the `sms-voice:SendTextMessage` resource to a specific ARN, provide that
    /// same
    /// ARN. If the formats do not match, requests fail with an
    /// `InvalidSmsRoleAccessPolicyException`.
    ///
    /// Depending on the destination country, you must provide an origination
    /// identity. For
    /// country-specific requirements, see [Supported
    /// countries and regions for SMS
    /// messaging](https://docs.aws.amazon.com/sms-voice/latest/userguide/phone-numbers-sms-by-country.html) in the Amazon Web Services End User Messaging SMS
    /// User Guide.
    origination_identity: ?[]const u8 = null,

    /// The Amazon Web Services Region of the Amazon Web Services End User Messaging
    /// SMS resources that Amazon Cognito uses to send messages. Amazon Web Services
    /// End User Messaging SMS must be available in your user pool's Region.
    ///
    /// If you omit this parameter, Amazon Cognito uses the same Region as your user
    /// pool. You can also set this parameter to your user pool's Region explicitly.
    /// Amazon Cognito rejects any other value with an `InvalidParameterException`.
    region: ?[]const u8 = null,

    pub const json_field_names = .{
        .caller_arn = "CallerArn",
        .configuration_set_name = "ConfigurationSetName",
        .external_id = "ExternalId",
        .in_entity_id = "InEntityId",
        .in_template_id = "InTemplateId",
        .origination_identity = "OriginationIdentity",
        .region = "Region",
    };
};
