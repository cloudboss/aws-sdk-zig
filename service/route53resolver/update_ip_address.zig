/// Provides information about the IP address type in response to
/// [UpdateResolverEndpoint](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_UpdateResolverEndpoint.html).
pub const UpdateIpAddress = struct {
    /// The ID of the IP address, specified by the `ResolverEndpointId`.
    ip_id: []const u8,

    /// The IPv6 address that you want to use for DNS queries.
    ipv_6: []const u8,

    pub const json_field_names = .{
        .ip_id = "IpId",
        .ipv_6 = "Ipv6",
    };
};
