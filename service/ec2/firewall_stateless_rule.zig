const PortRange = @import("port_range.zig").PortRange;

/// Describes a stateless rule.
pub const FirewallStatelessRule = struct {
    /// The destination ports.
    destination_ports: ?[]const PortRange,

    /// The destination IP addresses, in CIDR notation.
    destinations: ?[]const []const u8,

    /// The rule priority.
    priority: ?i32,

    /// The protocols.
    protocols: ?[]const i32,

    /// The rule action. The possible values are `pass`, `drop`, and
    /// `forward_to_site`.
    rule_action: ?[]const u8,

    /// The ARN of the stateless rule group.
    rule_group_arn: ?[]const u8,

    /// The source ports.
    source_ports: ?[]const PortRange,

    /// The source IP addresses, in CIDR notation.
    sources: ?[]const []const u8,
};
