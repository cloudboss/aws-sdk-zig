const IpAddressStatus = @import("ip_address_status.zig").IpAddressStatus;

/// In the response to a
/// [GetResolverEndpoint](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_GetResolverEndpoint.html)
/// request, information about the IP addresses that the Resolver endpoint uses
/// for DNS queries.
pub const IpAddressResponse = struct {
    /// The date and time that the IP address was created, in Unix time format and
    /// Coordinated Universal Time (UTC).
    creation_time: ?[]const u8,

    /// One IPv4 address that the Resolver endpoint uses for DNS queries.
    ip: ?[]const u8,

    /// The ID of one IP address.
    ip_id: ?[]const u8,

    /// One IPv6 address that the Resolver endpoint uses for DNS queries.
    ipv_6: ?[]const u8,

    /// The date and time that the IP address was last modified, in Unix time format
    /// and Coordinated Universal Time (UTC).
    modification_time: ?[]const u8,

    /// A status code that gives the current status of the request.
    status: ?IpAddressStatus,

    /// A message that provides additional information about the status of the
    /// request.
    status_message: ?[]const u8,

    /// The ID of one subnet.
    subnet_id: ?[]const u8,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .ip = "Ip",
        .ip_id = "IpId",
        .ipv_6 = "Ipv6",
        .modification_time = "ModificationTime",
        .status = "Status",
        .status_message = "StatusMessage",
        .subnet_id = "SubnetId",
    };
};
