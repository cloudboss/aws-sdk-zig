const PolicyVariables = @import("policy_variables.zig").PolicyVariables;
const StatefulEngineOptions = @import("stateful_engine_options.zig").StatefulEngineOptions;
const StatefulRuleGroupReference = @import("stateful_rule_group_reference.zig").StatefulRuleGroupReference;
const CustomAction = @import("custom_action.zig").CustomAction;
const StatelessRuleGroupReference = @import("stateless_rule_group_reference.zig").StatelessRuleGroupReference;

/// The firewall policy defines the behavior of a firewall using a collection of
/// stateless
/// and stateful rule groups and other settings. You can use one firewall policy
/// for multiple
/// firewalls.
///
/// This, along with FirewallPolicyResponse, define the policy.
/// You can retrieve all objects for a firewall policy by calling
/// DescribeFirewallPolicy.
pub const FirewallPolicy = struct {
    /// When true, prevents TCP and TLS packets from reaching destination servers
    /// until TLS Inspection has evaluated Server Name Indication (SNI) rules.
    /// Requires an associated TLS Inspection configuration.
    enable_tls_session_holding: ?bool = null,

    /// Contains variables that you can use to override default Suricata settings in
    /// your firewall policy.
    policy_variables: ?PolicyVariables = null,

    /// The default actions to take on a packet that doesn't match any stateful
    /// rules. The stateful default action is optional,
    /// and is only valid when using the strict rule order.
    ///
    /// Valid values of the stateful default action:
    ///
    /// * aws:drop_strict
    ///
    /// * aws:drop_established
    ///
    /// * aws:alert_strict
    ///
    /// * aws:alert_established
    ///
    /// For more information, see
    /// [Strict evaluation
    /// order](https://docs.aws.amazon.com/network-firewall/latest/developerguide/suricata-rule-evaluation-order.html#suricata-strict-rule-evaluation-order.html) in the *Network Firewall Developer Guide*.
    stateful_default_actions: ?[]const []const u8 = null,

    /// Additional options governing how Network Firewall handles stateful rules.
    /// The stateful
    /// rule groups that you use in your policy must have stateful rule options
    /// settings that are compatible with these settings.
    stateful_engine_options: ?StatefulEngineOptions = null,

    /// References to the stateful rule groups that are used in the policy. These
    /// define the
    /// inspection criteria in stateful rules.
    stateful_rule_group_references: ?[]const StatefulRuleGroupReference = null,

    /// The custom action definitions that are available for use in the firewall
    /// policy's
    /// `StatelessDefaultActions` setting. You name each custom action that you
    /// define, and then you can use it by name in your default actions
    /// specifications.
    stateless_custom_actions: ?[]const CustomAction = null,

    /// The actions to take on a packet if it doesn't match any of the stateless
    /// rules in the
    /// policy. If you want non-matching packets to be forwarded for stateful
    /// inspection, specify
    /// `aws:forward_to_sfe`.
    ///
    /// You must specify one of the standard actions: `aws:pass`,
    /// `aws:drop`, or `aws:forward_to_sfe`. In addition, you can specify
    /// custom actions that are compatible with your standard section choice.
    ///
    /// For example, you could specify `["aws:pass"]` or you could specify
    /// `["aws:pass", “customActionName”]`. For information about compatibility, see
    /// the custom action descriptions under CustomAction.
    stateless_default_actions: []const []const u8,

    /// The actions to take on a fragmented UDP packet if it doesn't match any of
    /// the stateless
    /// rules in the policy. Network Firewall only manages UDP packet fragments and
    /// silently drops packet fragments for other protocols.
    /// If you want non-matching fragmented UDP packets to be forwarded for
    /// stateful inspection, specify `aws:forward_to_sfe`.
    ///
    /// You must specify one of the standard actions: `aws:pass`,
    /// `aws:drop`, or `aws:forward_to_sfe`. In addition, you can specify
    /// custom actions that are compatible with your standard section choice.
    ///
    /// For example, you could specify `["aws:pass"]` or you could specify
    /// `["aws:pass", “customActionName”]`. For information about compatibility, see
    /// the custom action descriptions under CustomAction.
    stateless_fragment_default_actions: []const []const u8,

    /// References to the stateless rule groups that are used in the policy. These
    /// define the
    /// matching criteria in stateless rules.
    stateless_rule_group_references: ?[]const StatelessRuleGroupReference = null,

    /// The Amazon Resource Name (ARN) of the TLS inspection configuration.
    tls_inspection_configuration_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .enable_tls_session_holding = "EnableTLSSessionHolding",
        .policy_variables = "PolicyVariables",
        .stateful_default_actions = "StatefulDefaultActions",
        .stateful_engine_options = "StatefulEngineOptions",
        .stateful_rule_group_references = "StatefulRuleGroupReferences",
        .stateless_custom_actions = "StatelessCustomActions",
        .stateless_default_actions = "StatelessDefaultActions",
        .stateless_fragment_default_actions = "StatelessFragmentDefaultActions",
        .stateless_rule_group_references = "StatelessRuleGroupReferences",
        .tls_inspection_configuration_arn = "TLSInspectionConfigurationArn",
    };
};
