const StatefulAction = @import("stateful_action.zig").StatefulAction;
const Header = @import("header.zig").Header;
const RuleOption = @import("rule_option.zig").RuleOption;

/// A single Suricata rules specification, for use in a stateful rule group.
/// Use this option to specify a simple Suricata rule with protocol, source and
/// destination, ports, direction, and rule options.
/// For information about the Suricata `Rules` format, see
/// [Rules
/// Format](https://suricata.readthedocs.io/en/suricata-7.0.3/rules/intro.html).
pub const StatefulRule = struct {
    /// Defines what Network Firewall should do with the packets in a traffic flow
    /// when the flow
    /// matches the stateful rule criteria. For all actions, Network Firewall
    /// performs the specified
    /// action and discontinues stateful inspection of the traffic flow.
    ///
    /// The actions for a stateful rule are defined as follows:
    ///
    /// * **PASS** - Permits the packets to go to the
    /// intended destination.
    ///
    /// * **DROP** - Blocks the packets from going to
    /// the intended destination and sends an alert log message, if alert logging is
    /// configured in the Firewall
    /// LoggingConfiguration.
    ///
    /// * **ALERT** - Sends an alert log message, if alert logging is configured in
    ///   the Firewall
    /// LoggingConfiguration.
    ///
    /// You can use this action to test a rule that you intend to use to drop
    /// traffic. You
    /// can enable the rule with `ALERT` action, verify in the logs that the rule
    /// is filtering as you want, then change the action to `DROP`.
    ///
    /// * **REJECT** - Drops traffic that matches the conditions of the stateful
    ///   rule, and sends a TCP reset packet back to sender of the packet. A TCP
    ///   reset packet is a packet with no payload and an RST bit contained in the
    ///   TCP header flags. REJECT is available only for TCP traffic. This option
    ///   doesn't support FTP or IMAP protocols.
    action: StatefulAction,

    /// The stateful inspection criteria for this rule, used to inspect traffic
    /// flows.
    header: Header,

    /// Additional options for the rule. These are the Suricata `RuleOptions`
    /// settings.
    rule_options: []const RuleOption,

    pub const json_field_names = .{
        .action = "Action",
        .header = "Header",
        .rule_options = "RuleOptions",
    };
};
