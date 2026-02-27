const AWSManagedRulesACFPRuleSet = @import("aws_managed_rules_acfp_rule_set.zig").AWSManagedRulesACFPRuleSet;
const AWSManagedRulesAntiDDoSRuleSet = @import("aws_managed_rules_anti_d_do_s_rule_set.zig").AWSManagedRulesAntiDDoSRuleSet;
const AWSManagedRulesATPRuleSet = @import("aws_managed_rules_atp_rule_set.zig").AWSManagedRulesATPRuleSet;
const AWSManagedRulesBotControlRuleSet = @import("aws_managed_rules_bot_control_rule_set.zig").AWSManagedRulesBotControlRuleSet;
const PasswordField = @import("password_field.zig").PasswordField;
const PayloadType = @import("payload_type.zig").PayloadType;
const UsernameField = @import("username_field.zig").UsernameField;

/// Additional information that's used by a managed rule group. Many managed
/// rule groups don't require this.
///
/// The rule groups used for intelligent threat mitigation require additional
/// configuration:
///
/// * Use the `AWSManagedRulesACFPRuleSet` configuration object to configure the
///   account creation fraud prevention managed rule group. The configuration
///   includes the registration and sign-up pages of your application and the
///   locations in the account creation request payload of data, such as the
///   user email and phone number fields.
///
/// * Use the `AWSManagedRulesAntiDDoSRuleSet` configuration object to configure
///   the anti-DDoS managed rule group. The configuration includes the
///   sensitivity levels to use in the rules that typically block and challenge
///   requests that might be participating in DDoS attacks and the specification
///   to use to indicate whether a request can handle a silent browser
///   challenge.
///
/// * Use the `AWSManagedRulesATPRuleSet` configuration object to configure the
///   account takeover prevention managed rule group. The configuration includes
///   the sign-in page of your application and the locations in the login
///   request payload of data such as the username and password.
///
/// * Use the `AWSManagedRulesBotControlRuleSet` configuration object to
///   configure the
/// protection level that you want the Bot Control rule group to use.
///
/// For example specifications, see the examples section of CreateWebACL.
pub const ManagedRuleGroupConfig = struct {
    /// Additional configuration for using the account creation fraud prevention
    /// (ACFP) managed rule group, `AWSManagedRulesACFPRuleSet`.
    /// Use this to provide account creation request information to the rule group.
    /// For web ACLs that protect CloudFront distributions, use this to also provide
    /// the information about how your distribution responds to account creation
    /// requests.
    ///
    /// For information
    /// about using the ACFP managed rule group, see [WAF Fraud Control account
    /// creation fraud prevention (ACFP) rule
    /// group](https://docs.aws.amazon.com/waf/latest/developerguide/aws-managed-rule-groups-acfp.html)
    /// and [WAF Fraud Control account creation fraud prevention
    /// (ACFP)](https://docs.aws.amazon.com/waf/latest/developerguide/waf-acfp.html)
    /// in the *WAF Developer Guide*.
    aws_managed_rules_acfp_rule_set: ?AWSManagedRulesACFPRuleSet,

    /// Additional configuration for using the anti-DDoS managed rule group,
    /// `AWSManagedRulesAntiDDoSRuleSet`.
    /// Use this to configure anti-DDoS behavior for the rule group.
    ///
    /// For information
    /// about using the anti-DDoS managed rule group, see [WAF Anti-DDoS rule
    /// group](https://docs.aws.amazon.com/waf/latest/developerguide/aws-managed-rule-groups-anti-ddos.html)
    /// and [Distributed Denial of Service (DDoS)
    /// prevention](https://docs.aws.amazon.com/waf/latest/developerguide/waf-anti-ddos.html)
    /// in the *WAF Developer Guide*.
    aws_managed_rules_anti_d_do_s_rule_set: ?AWSManagedRulesAntiDDoSRuleSet,

    /// Additional configuration for using the account takeover prevention (ATP)
    /// managed rule group, `AWSManagedRulesATPRuleSet`.
    /// Use this to provide login request information to the rule group. For web
    /// ACLs that protect CloudFront distributions, use this to also provide
    /// the information about how your distribution responds to login requests.
    ///
    /// This configuration replaces the individual configuration fields in
    /// `ManagedRuleGroupConfig` and provides additional feature configuration.
    ///
    /// For information
    /// about using the ATP managed rule group, see [WAF Fraud Control account
    /// takeover prevention (ATP) rule
    /// group](https://docs.aws.amazon.com/waf/latest/developerguide/aws-managed-rule-groups-atp.html)
    /// and [WAF Fraud Control account takeover prevention
    /// (ATP)](https://docs.aws.amazon.com/waf/latest/developerguide/waf-atp.html)
    /// in the *WAF Developer Guide*.
    aws_managed_rules_atp_rule_set: ?AWSManagedRulesATPRuleSet,

    /// Additional configuration for using the Bot Control managed rule group. Use
    /// this to specify the
    /// inspection level that you want to use. For information
    /// about using the Bot Control managed rule group, see [WAF Bot Control rule
    /// group](https://docs.aws.amazon.com/waf/latest/developerguide/aws-managed-rule-groups-bot.html)
    /// and [WAF Bot
    /// Control](https://docs.aws.amazon.com/waf/latest/developerguide/waf-bot-control.html)
    /// in the *WAF Developer Guide*.
    aws_managed_rules_bot_control_rule_set: ?AWSManagedRulesBotControlRuleSet,

    /// Instead of this setting, provide your configuration under
    /// `AWSManagedRulesATPRuleSet`.
    login_path: ?[]const u8,

    /// Instead of this setting, provide your configuration under the request
    /// inspection configuration for `AWSManagedRulesATPRuleSet` or
    /// `AWSManagedRulesACFPRuleSet`.
    password_field: ?PasswordField,

    /// Instead of this setting, provide your configuration under the request
    /// inspection configuration for `AWSManagedRulesATPRuleSet` or
    /// `AWSManagedRulesACFPRuleSet`.
    payload_type: ?PayloadType,

    /// Instead of this setting, provide your configuration under the request
    /// inspection configuration for `AWSManagedRulesATPRuleSet` or
    /// `AWSManagedRulesACFPRuleSet`.
    username_field: ?UsernameField,

    pub const json_field_names = .{
        .aws_managed_rules_acfp_rule_set = "AWSManagedRulesACFPRuleSet",
        .aws_managed_rules_anti_d_do_s_rule_set = "AWSManagedRulesAntiDDoSRuleSet",
        .aws_managed_rules_atp_rule_set = "AWSManagedRulesATPRuleSet",
        .aws_managed_rules_bot_control_rule_set = "AWSManagedRulesBotControlRuleSet",
        .login_path = "LoginPath",
        .password_field = "PasswordField",
        .payload_type = "PayloadType",
        .username_field = "UsernameField",
    };
};
