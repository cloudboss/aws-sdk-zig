/// In an
/// [UpdateResolverEndpoint](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_UpdateResolverEndpoint.html)
/// request, information about an IP address to update.
pub const IpAddressUpdate = struct {
    /// The new IPv4 address.
    ip: ?[]const u8 = null,

    /// *Only when removing an IP address from a Resolver endpoint*: The ID of the
    /// IP address that you want to remove.
    /// To get this ID, use
    /// [GetResolverEndpoint](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_GetResolverEndpoint.html).
    ip_id: ?[]const u8 = null,

    /// The new IPv6 address.
    ipv_6: ?[]const u8 = null,

    /// The ID of the subnet that includes the IP address that you want to update.
    /// To get this ID, use
    /// [GetResolverEndpoint](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_GetResolverEndpoint.html).
    subnet_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .ip = "Ip",
        .ip_id = "IpId",
        .ipv_6 = "Ipv6",
        .subnet_id = "SubnetId",
    };
};
