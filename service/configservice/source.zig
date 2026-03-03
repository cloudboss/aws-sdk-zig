const CustomPolicyDetails = @import("custom_policy_details.zig").CustomPolicyDetails;
const Owner = @import("owner.zig").Owner;
const SourceDetail = @import("source_detail.zig").SourceDetail;

/// Provides the CustomPolicyDetails, the rule owner (`Amazon Web Services` for
/// managed rules, `CUSTOM_POLICY` for Custom Policy rules, and `CUSTOM_LAMBDA`
/// for Custom Lambda rules), the rule
/// identifier, and the events that cause the evaluation of your Amazon Web
/// Services
/// resources.
pub const Source = struct {
    /// Provides the runtime system, policy definition, and whether debug logging is
    /// enabled. Required when owner is set to `CUSTOM_POLICY`.
    custom_policy_details: ?CustomPolicyDetails = null,

    /// Indicates whether Amazon Web Services or the customer owns and manages the
    /// Config rule.
    ///
    /// Config Managed Rules are predefined rules owned by Amazon Web Services. For
    /// more information, see [Config Managed
    /// Rules](https://docs.aws.amazon.com/config/latest/developerguide/evaluate-config_use-managed-rules.html) in the *Config developer guide*.
    ///
    /// Config Custom Rules are rules that you can develop either with Guard
    /// (`CUSTOM_POLICY`) or Lambda (`CUSTOM_LAMBDA`). For more information, see
    /// [Config Custom Rules
    /// ](https://docs.aws.amazon.com/config/latest/developerguide/evaluate-config_develop-rules.html) in the *Config developer guide*.
    owner: Owner,

    /// Provides the source and the message types that cause Config to evaluate your
    /// Amazon Web Services resources against a rule. It also provides the frequency
    /// with which you want Config to run evaluations for the rule if the trigger
    /// type is periodic.
    ///
    /// If the owner is set to `CUSTOM_POLICY`, the only acceptable values for the
    /// Config rule trigger message type are `ConfigurationItemChangeNotification`
    /// and `OversizedConfigurationItemChangeNotification`.
    source_details: ?[]const SourceDetail = null,

    /// For Config Managed rules, a predefined identifier from a
    /// list. For example, `IAM_PASSWORD_POLICY` is a managed
    /// rule. To reference a managed rule, see [List of Config Managed
    /// Rules](https://docs.aws.amazon.com/config/latest/developerguide/managed-rules-by-aws-config.html).
    ///
    /// For Config Custom Lambda rules, the identifier is the Amazon Resource Name
    /// (ARN) of the rule's Lambda function, such as
    /// `arn:aws:lambda:us-east-2:123456789012:function:custom_rule_name`.
    ///
    /// For Config Custom Policy rules, this field will be ignored.
    source_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .custom_policy_details = "CustomPolicyDetails",
        .owner = "Owner",
        .source_details = "SourceDetails",
        .source_identifier = "SourceIdentifier",
    };
};
