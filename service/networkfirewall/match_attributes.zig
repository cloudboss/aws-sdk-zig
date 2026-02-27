const PortRange = @import("port_range.zig").PortRange;
const Address = @import("address.zig").Address;
const TCPFlagField = @import("tcp_flag_field.zig").TCPFlagField;

/// Criteria for Network Firewall to use to inspect an individual packet in
/// stateless rule inspection. Each match attributes set can include one or more
/// items such as IP address, CIDR range, port number, protocol, and TCP flags.
pub const MatchAttributes = struct {
    /// The destination port to inspect for. You can specify an individual port,
    /// for example `1994` and you can specify a port range, for example
    /// `1990:1994`.
    /// To match with any port, specify `ANY`.
    ///
    /// This setting is only used for protocols 6 (TCP) and 17 (UDP).
    destination_ports: ?[]const PortRange,

    /// The destination IP addresses and address ranges to inspect for, in CIDR
    /// notation. If not
    /// specified, this matches with any destination address.
    destinations: ?[]const Address,

    /// The protocols to inspect for, specified using the assigned internet protocol
    /// number (IANA)
    /// for each protocol. If not specified, this matches with any protocol.
    protocols: ?[]const i32,

    /// The source port to inspect for. You can specify an individual port,
    /// for example `1994` and you can specify a port range, for example
    /// `1990:1994`.
    /// To match with any port, specify `ANY`.
    ///
    /// If not specified, this matches with any source port.
    ///
    /// This setting is only used for protocols 6 (TCP) and 17 (UDP).
    source_ports: ?[]const PortRange,

    /// The source IP addresses and address ranges to inspect for, in CIDR notation.
    /// If not
    /// specified, this matches with any source address.
    sources: ?[]const Address,

    /// The TCP flags and masks to inspect for. If not specified, this matches with
    /// any
    /// settings. This setting is only used for protocol 6 (TCP).
    tcp_flags: ?[]const TCPFlagField,

    pub const json_field_names = .{
        .destination_ports = "DestinationPorts",
        .destinations = "Destinations",
        .protocols = "Protocols",
        .source_ports = "SourcePorts",
        .sources = "Sources",
        .tcp_flags = "TCPFlags",
    };
};
