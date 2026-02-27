/// In a
/// [CreateResolverEndpoint](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_CreateResolverEndpoint.html)
/// request, the IP address that DNS queries originate from (for outbound
/// endpoints) or that you forward DNS queries to (for inbound endpoints).
/// `IpAddressRequest` also includes the ID of the subnet that contains the IP
/// address.
pub const IpAddressRequest = struct {
    /// The IPv4 address that you want to use for DNS queries.
    ip: ?[]const u8,

    /// The IPv6 address that you want to use for DNS queries.
    ipv_6: ?[]const u8,

    /// The ID of the subnet that contains the IP address.
    subnet_id: []const u8,

    pub const json_field_names = .{
        .ip = "Ip",
        .ipv_6 = "Ipv6",
        .subnet_id = "SubnetId",
    };
};
