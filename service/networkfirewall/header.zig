const StatefulRuleDirection = @import("stateful_rule_direction.zig").StatefulRuleDirection;
const StatefulRuleProtocol = @import("stateful_rule_protocol.zig").StatefulRuleProtocol;

/// The basic rule criteria for Network Firewall to use to inspect packet
/// headers in stateful
/// traffic flow inspection. Traffic flows that match the criteria are a match
/// for the
/// corresponding StatefulRule.
pub const Header = struct {
    /// The destination IP address or address range to inspect for, in CIDR
    /// notation.
    /// To match with any address, specify `ANY`.
    ///
    /// Specify an IP address or a block of IP addresses in Classless Inter-Domain
    /// Routing (CIDR) notation. Network Firewall supports all address ranges for
    /// IPv4 and IPv6.
    ///
    /// Examples:
    ///
    /// * To configure Network Firewall to inspect for the IP address 192.0.2.44,
    ///   specify `192.0.2.44/32`.
    ///
    /// * To configure Network Firewall to inspect for IP addresses from 192.0.2.0
    ///   to 192.0.2.255, specify `192.0.2.0/24`.
    ///
    /// * To configure Network Firewall to inspect for the IP address
    ///   1111:0000:0000:0000:0000:0000:0000:0111, specify
    ///   `1111:0000:0000:0000:0000:0000:0000:0111/128`.
    ///
    /// * To configure Network Firewall to inspect for IP addresses from
    ///   1111:0000:0000:0000:0000:0000:0000:0000 to
    ///   1111:0000:0000:0000:ffff:ffff:ffff:ffff, specify
    ///   `1111:0000:0000:0000:0000:0000:0000:0000/64`.
    ///
    /// For more information about CIDR notation, see the Wikipedia entry [Classless
    /// Inter-Domain
    /// Routing](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing).
    destination: []const u8,

    /// The destination port to inspect for. You can specify an individual port,
    /// for example `1994` and you can specify a port range, for example
    /// `1990:1994`.
    /// To match with any port, specify `ANY`.
    destination_port: []const u8,

    /// The direction of traffic flow to inspect. If set to `ANY`, the inspection
    /// matches bidirectional traffic, both from the source to the destination and
    /// from the
    /// destination to the source. If set to `FORWARD`, the inspection only matches
    /// traffic going from the source to the destination.
    direction: StatefulRuleDirection,

    /// The protocol to inspect for. To specify all, you can use `IP`, because all
    /// traffic on Amazon Web Services and on the internet is IP.
    protocol: StatefulRuleProtocol,

    /// The source IP address or address range to inspect for, in CIDR notation.
    /// To match with any address, specify `ANY`.
    ///
    /// Specify an IP address or a block of IP addresses in Classless Inter-Domain
    /// Routing (CIDR) notation. Network Firewall supports all address ranges for
    /// IPv4 and IPv6.
    ///
    /// Examples:
    ///
    /// * To configure Network Firewall to inspect for the IP address 192.0.2.44,
    ///   specify `192.0.2.44/32`.
    ///
    /// * To configure Network Firewall to inspect for IP addresses from 192.0.2.0
    ///   to 192.0.2.255, specify `192.0.2.0/24`.
    ///
    /// * To configure Network Firewall to inspect for the IP address
    ///   1111:0000:0000:0000:0000:0000:0000:0111, specify
    ///   `1111:0000:0000:0000:0000:0000:0000:0111/128`.
    ///
    /// * To configure Network Firewall to inspect for IP addresses from
    ///   1111:0000:0000:0000:0000:0000:0000:0000 to
    ///   1111:0000:0000:0000:ffff:ffff:ffff:ffff, specify
    ///   `1111:0000:0000:0000:0000:0000:0000:0000/64`.
    ///
    /// For more information about CIDR notation, see the Wikipedia entry [Classless
    /// Inter-Domain
    /// Routing](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing).
    source: []const u8,

    /// The source port to inspect for. You can specify an individual port,
    /// for example `1994` and you can specify a port range, for example
    /// `1990:1994`.
    /// To match with any port, specify `ANY`.
    source_port: []const u8,

    pub const json_field_names = .{
        .destination = "Destination",
        .destination_port = "DestinationPort",
        .direction = "Direction",
        .protocol = "Protocol",
        .source = "Source",
        .source_port = "SourcePort",
    };
};
