const Tag = @import("tag.zig").Tag;

/// Describes a customer gateway.
pub const CustomerGateway = struct {
    /// The customer gateway device's Border Gateway Protocol (BGP) Autonomous
    /// System Number
    /// (ASN).
    ///
    /// Valid values: `1` to `2,147,483,647`
    bgp_asn: ?[]const u8 = null,

    /// The customer gateway device's Border Gateway Protocol (BGP) Autonomous
    /// System Number
    /// (ASN).
    ///
    /// Valid values: `2,147,483,648` to `4,294,967,295`
    bgp_asn_extended: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the customer gateway certificate.
    certificate_arn: ?[]const u8 = null,

    /// The ID of the customer gateway.
    customer_gateway_id: ?[]const u8 = null,

    /// The name of customer gateway device.
    device_name: ?[]const u8 = null,

    /// The IP address for the customer gateway device's outside interface. The
    /// address must be static. If `OutsideIpAddressType` in your VPN connection
    /// options is set to `PrivateIpv4`, you can use an RFC6598 or RFC1918 private
    /// IPv4 address. If
    /// `OutsideIpAddressType` is set to `PublicIpv4`, you can use a public IPv4
    /// address. If `OutsideIpAddressType` is set to `Ipv6`, you can use a public
    /// IPv6 address.
    ip_address: ?[]const u8 = null,

    /// The current state of the customer gateway (`pending | available | deleting |
    /// deleted`).
    state: ?[]const u8 = null,

    /// Any tags assigned to the customer gateway.
    tags: ?[]const Tag = null,

    /// The type of VPN connection the customer gateway supports
    /// (`ipsec.1`).
    @"type": ?[]const u8 = null,
};
