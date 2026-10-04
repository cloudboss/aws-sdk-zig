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
    ///
    /// We recommend using [VPC Resolver on
    /// Outposts](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/outpost-resolver-getting-started.html) to create endpoints on Outposts Racks.
    ///
    /// Outposts subnets with [Local Network Interface
    /// (LNI)](https://docs.aws.amazon.com/outposts/latest/server-userguide/local-network-interface.html) enabled are not compatible with Route 53 Resolver endpoints. If you enable LNI on a subnet that contains Route 53 Resolver endpoint elastic network interfaces (ENIs), those ENIs will stop functioning. For more information, see [Subnet compatibility for Resolver endpoints](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/best-practices-resolver.html#best-practices-resolver-subnet-compatibility) in the *Amazon Route 53 Developer Guide*.
    subnet_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .ip = "Ip",
        .ip_id = "IpId",
        .ipv_6 = "Ipv6",
        .subnet_id = "SubnetId",
    };
};
