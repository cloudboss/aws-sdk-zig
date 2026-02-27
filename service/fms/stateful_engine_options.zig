const RuleOrder = @import("rule_order.zig").RuleOrder;
const StreamExceptionPolicy = @import("stream_exception_policy.zig").StreamExceptionPolicy;

/// Configuration settings for the handling of the stateful rule groups in a
/// Network Firewall firewall policy.
pub const StatefulEngineOptions = struct {
    /// Indicates how to manage the order of stateful rule evaluation for the
    /// policy.
    /// Stateful rules are provided to the rule engine
    /// as Suricata compatible strings, and Suricata evaluates them based on certain
    /// settings. For more
    /// information, see [Evaluation order for stateful
    /// rules](https://docs.aws.amazon.com/network-firewall/latest/developerguide/suricata-rule-evaluation-order.html) in the *Network Firewall Developer Guide*.
    ///
    /// Default: `DEFAULT_ACTION_ORDER`
    rule_order: ?RuleOrder,

    /// Indicates how Network Firewall should handle traffic when a network
    /// connection breaks midstream.
    ///
    /// * `DROP` - Fail closed and drop all subsequent traffic going to the
    ///   firewall.
    ///
    /// * `CONTINUE` - Continue to apply rules to subsequent traffic without context
    ///   from traffic before the break. This impacts the behavior of rules that
    ///   depend on context. For example, with a stateful rule that drops HTTP
    ///   traffic, Network Firewall won't match subsequent traffic because the it
    ///   won't have the context from session initialization, which defines the
    ///   application layer protocol as HTTP. However, a TCP-layer rule using a
    ///   `flow:stateless` rule would still match, and so would the
    ///   `aws:drop_strict` default action.
    ///
    /// * `REJECT` - Fail closed and drop all subsequent traffic going to the
    ///   firewall. With this option, Network Firewall also sends a TCP reject
    ///   packet back to the client so the client can immediately establish a new
    ///   session. With the new session, Network Firewall will have context and will
    ///   apply rules appropriately.
    ///
    /// For applications that are reliant on long-lived TCP connections that trigger
    /// Gateway Load Balancer idle timeouts, this is the recommended setting.
    ///
    /// * `FMS_IGNORE` - Firewall Manager doesn't monitor or modify the Network
    ///   Firewall stream exception policy settings.
    ///
    /// For more information, see
    /// [Stream exception policy in your firewall
    /// policy](https://docs.aws.amazon.com/network-firewall/latest/developerguide/stream-exception-policy.html)
    /// in the *Network Firewall Developer Guide*.
    ///
    /// Default: `FMS_IGNORE`
    stream_exception_policy: ?StreamExceptionPolicy,

    pub const json_field_names = .{
        .rule_order = "RuleOrder",
        .stream_exception_policy = "StreamExceptionPolicy",
    };
};
