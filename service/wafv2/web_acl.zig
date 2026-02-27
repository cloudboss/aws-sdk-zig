const aws = @import("aws");

const ApplicationConfig = @import("application_config.zig").ApplicationConfig;
const AssociationConfig = @import("association_config.zig").AssociationConfig;
const CaptchaConfig = @import("captcha_config.zig").CaptchaConfig;
const ChallengeConfig = @import("challenge_config.zig").ChallengeConfig;
const CustomResponseBody = @import("custom_response_body.zig").CustomResponseBody;
const DataProtectionConfig = @import("data_protection_config.zig").DataProtectionConfig;
const DefaultAction = @import("default_action.zig").DefaultAction;
const OnSourceDDoSProtectionConfig = @import("on_source_d_do_s_protection_config.zig").OnSourceDDoSProtectionConfig;
const FirewallManagerRuleGroup = @import("firewall_manager_rule_group.zig").FirewallManagerRuleGroup;
const Rule = @import("rule.zig").Rule;
const VisibilityConfig = @import("visibility_config.zig").VisibilityConfig;

/// A web ACL defines a collection of rules to use to inspect and control web
/// requests. Each rule has a statement that defines what to look for in web
/// requests and an action that WAF applies to requests that match the
/// statement. In the web ACL, you assign a default action to take (allow,
/// block) for any request that does not match any of the rules. The rules in a
/// web ACL can be a combination of the types Rule, RuleGroup, and managed rule
/// group. You can associate a web ACL with one or more Amazon Web Services
/// resources to protect. The resource types include Amazon CloudFront
/// distribution, Amazon API Gateway REST API, Application Load Balancer,
/// AppSync GraphQL API, Amazon Cognito user pool, App Runner service, Amplify
/// application, and Amazon Web Services Verified Access instance.
pub const WebACL = struct {
    /// Returns a list of `ApplicationAttribute`s.
    application_config: ?ApplicationConfig,

    /// The Amazon Resource Name (ARN) of the web ACL that you want to associate
    /// with the
    /// resource.
    arn: []const u8,

    /// Specifies custom configurations for the associations between the web ACL and
    /// protected resources.
    ///
    /// Use this to customize the maximum size of the request body that your
    /// protected resources forward to WAF for inspection. You can
    /// customize this setting for CloudFront, API Gateway, Amazon Cognito, App
    /// Runner, or Verified Access resources. The default setting is 16 KB (16,384
    /// bytes).
    ///
    /// You are charged additional fees when your protected resources forward body
    /// sizes that are larger than the default. For more information, see [WAF
    /// Pricing](http://aws.amazon.com/waf/pricing/).
    ///
    /// For Application Load Balancer and AppSync, the limit is fixed at 8 KB (8,192
    /// bytes).
    association_config: ?AssociationConfig,

    /// The web ACL capacity units (WCUs) currently being used by this web ACL.
    ///
    /// WAF uses WCUs to calculate and control the operating
    /// resources that are used to run your rules, rule groups, and web ACLs. WAF
    /// calculates capacity differently for each rule type, to reflect the relative
    /// cost of each rule.
    /// Simple rules that cost little to run use fewer WCUs than more complex rules
    /// that use more processing power.
    /// Rule group capacity is fixed at creation, which helps users plan their
    /// web ACL WCU usage when they use a rule group. For more information, see [WAF
    /// web ACL capacity units
    /// (WCU)](https://docs.aws.amazon.com/waf/latest/developerguide/aws-waf-capacity-units.html)
    /// in the *WAF Developer Guide*.
    capacity: i64 = 0,

    /// Specifies how WAF should handle `CAPTCHA` evaluations for rules that don't
    /// have their own `CaptchaConfig` settings. If you don't specify this, WAF uses
    /// its default settings for `CaptchaConfig`.
    captcha_config: ?CaptchaConfig,

    /// Specifies how WAF should handle challenge evaluations for rules that don't
    /// have
    /// their own `ChallengeConfig` settings. If you don't specify this, WAF uses
    /// its default settings for `ChallengeConfig`.
    challenge_config: ?ChallengeConfig,

    /// A map of custom response keys and content bodies. When you create a rule
    /// with a block action, you can send a custom response to the web request. You
    /// define these for the web ACL, and then use them in the rules and default
    /// actions that you define in the web ACL.
    ///
    /// For information about customizing web requests and responses,
    /// see [Customizing web requests and responses in
    /// WAF](https://docs.aws.amazon.com/waf/latest/developerguide/waf-custom-request-response.html)
    /// in the *WAF Developer Guide*.
    ///
    /// For information about the limits on count and size for custom request and
    /// response settings, see [WAF
    /// quotas](https://docs.aws.amazon.com/waf/latest/developerguide/limits.html)
    /// in the *WAF Developer Guide*.
    custom_response_bodies: ?[]const aws.map.MapEntry(CustomResponseBody),

    /// Specifies data protection to apply to the web request data for the web ACL.
    /// This is a web ACL level data protection option.
    ///
    /// The data protection that you configure for the web ACL alters the data
    /// that's available for any other data collection activity,
    /// including your WAF logging destinations, web ACL request sampling, and
    /// Amazon Security Lake data collection and management. Your other option for
    /// data protection is in the logging configuration, which only affects logging.
    data_protection_config: ?DataProtectionConfig,

    /// The action to perform if none of the `Rules` contained in the `WebACL`
    /// match.
    default_action: DefaultAction,

    /// A description of the web ACL that helps with identification.
    description: ?[]const u8,

    /// A unique identifier for the `WebACL`. This ID is returned in the responses
    /// to
    /// create and list commands. You use this ID to do things like get, update, and
    /// delete a
    /// `WebACL`.
    id: []const u8,

    /// The label namespace prefix for this web ACL. All labels added by rules in
    /// this web ACL have this prefix.
    ///
    /// * The syntax for the label namespace prefix for a web ACL is the following:
    ///
    /// `awswaf::webacl::`
    ///
    /// * When a rule with a label matches a web request, WAF adds the fully
    ///   qualified label to the request. A fully qualified label is made up of the
    ///   label namespace from the rule group or web ACL where the rule is defined
    ///   and the label from the rule, separated by a colon:
    ///
    /// `:`
    label_namespace: ?[]const u8,

    /// Indicates whether this web ACL was created by Firewall Manager and is being
    /// managed by Firewall Manager. If true, then only Firewall Manager can
    /// delete the web ACL or any Firewall Manager rule groups in the web ACL.
    /// See also the properties `RetrofittedByFirewallManager`,
    /// `PreProcessFirewallManagerRuleGroups`, and
    /// `PostProcessFirewallManagerRuleGroups`.
    managed_by_firewall_manager: bool = false,

    /// The name of the web ACL. You cannot change the name of a web ACL after you
    /// create it.
    name: []const u8,

    /// Configures the level of DDoS protection that applies to web ACLs associated
    /// with Application Load Balancers.
    on_source_d_do_s_protection_config: ?OnSourceDDoSProtectionConfig,

    /// The last set of rules for WAF to process in the web ACL. This is defined in
    /// an
    /// Firewall Manager WAF policy and contains only rule group references. You
    /// can't alter these. Any
    /// rules and rule groups that you define for the web ACL are prioritized before
    /// these.
    ///
    /// In the Firewall Manager WAF policy, the Firewall Manager administrator can
    /// define a set of rule groups to run
    /// first in the web ACL and a set of rule groups to run last. Within each set,
    /// the
    /// administrator prioritizes the rule groups, to determine their relative
    /// processing
    /// order.
    post_process_firewall_manager_rule_groups: ?[]const FirewallManagerRuleGroup,

    /// The first set of rules for WAF to process in the web ACL. This is defined in
    /// an
    /// Firewall Manager WAF policy and contains only rule group references. You
    /// can't alter these. Any
    /// rules and rule groups that you define for the web ACL are prioritized after
    /// these.
    ///
    /// In the Firewall Manager WAF policy, the Firewall Manager administrator can
    /// define a set of rule groups to run
    /// first in the web ACL and a set of rule groups to run last. Within each set,
    /// the
    /// administrator prioritizes the rule groups, to determine their relative
    /// processing
    /// order.
    pre_process_firewall_manager_rule_groups: ?[]const FirewallManagerRuleGroup,

    /// Indicates whether this web ACL was created by a customer account and then
    /// retrofitted by Firewall Manager. If true, then the web ACL is currently
    /// being
    /// managed by a Firewall Manager WAF policy, and only Firewall Manager can
    /// manage any Firewall Manager rule groups in the web ACL.
    /// See also the properties `ManagedByFirewallManager`,
    /// `PreProcessFirewallManagerRuleGroups`, and
    /// `PostProcessFirewallManagerRuleGroups`.
    retrofitted_by_firewall_manager: bool = false,

    /// The Rule statements used to identify the web requests that you
    /// want to manage. Each rule includes one top-level statement that WAF uses to
    /// identify matching
    /// web requests, and parameters that govern how WAF handles them.
    rules: ?[]const Rule,

    /// Specifies the domains that WAF should accept in a web request token. This
    /// enables the use of tokens across multiple protected websites. When WAF
    /// provides a token, it uses the domain of the Amazon Web Services resource
    /// that the web ACL is protecting. If you don't specify a list of token
    /// domains, WAF accepts tokens only for the domain of the protected resource.
    /// With a token domain list, WAF accepts the resource's host domain plus all
    /// domains in the token domain list, including their prefixed subdomains.
    token_domains: ?[]const []const u8,

    /// Defines and enables Amazon CloudWatch metrics and web request sample
    /// collection.
    visibility_config: VisibilityConfig,

    pub const json_field_names = .{
        .application_config = "ApplicationConfig",
        .arn = "ARN",
        .association_config = "AssociationConfig",
        .capacity = "Capacity",
        .captcha_config = "CaptchaConfig",
        .challenge_config = "ChallengeConfig",
        .custom_response_bodies = "CustomResponseBodies",
        .data_protection_config = "DataProtectionConfig",
        .default_action = "DefaultAction",
        .description = "Description",
        .id = "Id",
        .label_namespace = "LabelNamespace",
        .managed_by_firewall_manager = "ManagedByFirewallManager",
        .name = "Name",
        .on_source_d_do_s_protection_config = "OnSourceDDoSProtectionConfig",
        .post_process_firewall_manager_rule_groups = "PostProcessFirewallManagerRuleGroups",
        .pre_process_firewall_manager_rule_groups = "PreProcessFirewallManagerRuleGroups",
        .retrofitted_by_firewall_manager = "RetrofittedByFirewallManager",
        .rules = "Rules",
        .token_domains = "TokenDomains",
        .visibility_config = "VisibilityConfig",
    };
};
