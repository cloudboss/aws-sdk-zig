const PortRange = @import("port_range.zig").PortRange;
const Address = @import("address.zig").Address;

/// Settings that define the Secure Sockets Layer/Transport Layer Security
/// (SSL/TLS) traffic that Network Firewall should decrypt for inspection by the
/// stateful rule engine.
pub const ServerCertificateScope = struct {
    /// The destination ports to decrypt for inspection, in Transmission Control
    /// Protocol (TCP) format. If not specified, this matches with any destination
    /// port.
    ///
    /// You can specify individual ports, for example `1994`, and you can specify
    /// port ranges, such as `1990:1994`.
    destination_ports: ?[]const PortRange = null,

    /// The destination IP addresses and address ranges to decrypt for inspection,
    /// in CIDR notation. If not specified, this
    /// matches with any destination address.
    destinations: ?[]const Address = null,

    /// The protocols to inspect for, specified using the assigned internet protocol
    /// number (IANA)
    /// for each protocol. If not specified, this matches with any protocol.
    ///
    /// Network Firewall currently supports only TCP.
    protocols: ?[]const i32 = null,

    /// The source ports to decrypt for inspection, in Transmission Control Protocol
    /// (TCP) format. If not specified, this matches with any source port.
    ///
    /// You can specify individual ports, for example `1994`, and you can specify
    /// port ranges, such as `1990:1994`.
    source_ports: ?[]const PortRange = null,

    /// The source IP addresses and address ranges to decrypt for inspection, in
    /// CIDR notation. If not specified, this
    /// matches with any source address.
    sources: ?[]const Address = null,

    pub const json_field_names = .{
        .destination_ports = "DestinationPorts",
        .destinations = "Destinations",
        .protocols = "Protocols",
        .source_ports = "SourcePorts",
        .sources = "Sources",
    };
};
