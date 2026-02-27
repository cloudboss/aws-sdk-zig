const Protocol = @import("protocol.zig").Protocol;

/// In a
/// [CreateResolverRule](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_CreateResolverRule.html)
/// request, an array of the IPs that you want to forward DNS queries to.
pub const TargetAddress = struct {
    /// One IPv4 address that you want to forward DNS queries to.
    ip: ?[]const u8,

    /// One IPv6 address that you want to forward DNS queries to.
    ipv_6: ?[]const u8,

    /// The port at `Ip` that you want to forward DNS queries to.
    port: ?i32,

    /// The protocols for the target address. The protocol you choose needs to be
    /// supported by the outbound endpoint of the Resolver rule.
    protocol: ?Protocol,

    /// The Server Name Indication of the DoH server that you want to forward
    /// queries to.
    /// This is only used if the Protocol of the `TargetAddress` is `DoH`.
    server_name_indication: ?[]const u8,

    pub const json_field_names = .{
        .ip = "Ip",
        .ipv_6 = "Ipv6",
        .port = "Port",
        .protocol = "Protocol",
        .server_name_indication = "ServerNameIndication",
    };
};
