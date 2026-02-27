const FlowTimeouts = @import("flow_timeouts.zig").FlowTimeouts;
const RuleOrder = @import("rule_order.zig").RuleOrder;
const StreamExceptionPolicy = @import("stream_exception_policy.zig").StreamExceptionPolicy;

/// Configuration settings for the handling of the stateful rule groups in a
/// firewall policy.
pub const StatefulEngineOptions = struct {
    /// Configures the amount of time that can pass without any traffic sent through
    /// the firewall before the firewall determines that the connection is idle.
    flow_timeouts: ?FlowTimeouts,

    /// Indicates how to manage the order of stateful rule evaluation for the
    /// policy. `STRICT_ORDER` is the
    /// recommended option, but `DEFAULT_ACTION_ORDER` is the default option. With
    /// `STRICT_ORDER`,
    /// provide your rules in the order that you want them to be evaluated.
    /// You can then choose one or more default actions for packets that don't match
    /// any rules.
    /// Choose `STRICT_ORDER` to have the stateful rules engine determine the
    /// evaluation order of your rules.
    /// The default action for this rule order is `PASS`, followed by `DROP`,
    /// `REJECT`, and `ALERT` actions.
    /// Stateful rules are provided to the rule engine as Suricata compatible
    /// strings, and Suricata evaluates them based on your settings.
    /// For more information, see
    /// [Evaluation order for stateful
    /// rules](https://docs.aws.amazon.com/network-firewall/latest/developerguide/suricata-rule-evaluation-order.html) in the *Network Firewall Developer Guide*.
    rule_order: ?RuleOrder,

    /// Configures how Network Firewall processes traffic when a network connection
    /// breaks midstream. Network connections can break due to disruptions in
    /// external networks or within the firewall itself.
    ///
    /// * `DROP` - Network Firewall fails closed and drops all subsequent traffic
    ///   going to the firewall. This is the default behavior.
    ///
    /// * `CONTINUE` - Network Firewall continues to apply rules to the subsequent
    ///   traffic without context from traffic before the break. This impacts the
    ///   behavior of rules that depend on this context. For example, if you have a
    ///   stateful rule to `drop http` traffic, Network Firewall won't match the
    ///   traffic for this rule because the service won't have the context from
    ///   session initialization defining the application layer protocol as HTTP.
    ///   However, this behavior is rule dependent—a TCP-layer rule using a
    ///   `flow:stateless` rule would still match, as would the `aws:drop_strict`
    ///   default action.
    ///
    /// * `REJECT` - Network Firewall fails closed and drops all subsequent traffic
    ///   going to the firewall. Network Firewall also sends a TCP reject packet
    ///   back to your client so that the client can immediately establish a new
    ///   session. Network Firewall will have context about the new session and will
    ///   apply rules to the subsequent traffic.
    stream_exception_policy: ?StreamExceptionPolicy,

    pub const json_field_names = .{
        .flow_timeouts = "FlowTimeouts",
        .rule_order = "RuleOrder",
        .stream_exception_policy = "StreamExceptionPolicy",
    };
};
