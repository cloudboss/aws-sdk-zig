/// A single IP address specification. This is used in the MatchAttributes
/// source and destination specifications.
pub const Address = struct {
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
    address_definition: []const u8,

    pub const json_field_names = .{
        .address_definition = "AddressDefinition",
    };
};
