const aws = @import("aws");

const EndpointIpAddressType = @import("endpoint_ip_address_type.zig").EndpointIpAddressType;

/// A service-managed private endpoint provisioned within a customer VPC.
pub const ManagedVpcResource = struct {
    /// The IP address type used by the private endpoint, either IPV4 or IPV6.
    endpoint_ip_address_type: EndpointIpAddressType,

    /// The routing domain used to resolve traffic through the private endpoint.
    routing_domain: ?[]const u8 = null,

    /// The identifiers of the security groups associated with the private endpoint
    /// network interfaces.
    security_group_ids: ?[]const []const u8 = null,

    /// The identifiers of the subnets in which the private endpoint network
    /// interfaces are placed.
    subnet_ids: []const []const u8,

    /// The tags applied to the service-managed VPC resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The identifier of the VPC in which the private endpoint is provisioned.
    vpc_identifier: []const u8,

    pub const json_field_names = .{
        .endpoint_ip_address_type = "endpointIpAddressType",
        .routing_domain = "routingDomain",
        .security_group_ids = "securityGroupIds",
        .subnet_ids = "subnetIds",
        .tags = "tags",
        .vpc_identifier = "vpcIdentifier",
    };
};
