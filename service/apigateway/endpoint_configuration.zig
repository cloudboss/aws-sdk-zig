const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const EndpointType = @import("endpoint_type.zig").EndpointType;

/// The endpoint configuration to indicate the types of endpoints an API
/// (RestApi) or its custom domain name (DomainName) has and the IP address
/// types that can invoke it.
pub const EndpointConfiguration = struct {
    /// The IP address types that can invoke an API (RestApi) or a DomainName. Use
    /// `ipv4` to allow only IPv4 addresses to
    /// invoke an API or DomainName, or use `dualstack` to allow both IPv4 and IPv6
    /// addresses to invoke an API or a DomainName. For the
    /// `PRIVATE` endpoint type, only `dualstack` is supported.
    ip_address_type: ?IpAddressType,

    /// A list of endpoint types of an API (RestApi) or its custom domain name
    /// (DomainName). For an edge-optimized API and its custom domain name, the
    /// endpoint type is `"EDGE"`. For a regional API and its custom domain name,
    /// the endpoint type is `REGIONAL`. For a private API, the endpoint type is
    /// `PRIVATE`.
    types: ?[]const EndpointType,

    /// A list of VpcEndpointIds of an API (RestApi) against which to create Route53
    /// ALIASes. It is only supported for `PRIVATE` endpoint type.
    vpc_endpoint_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .ip_address_type = "ipAddressType",
        .types = "types",
        .vpc_endpoint_ids = "vpcEndpointIds",
    };
};
