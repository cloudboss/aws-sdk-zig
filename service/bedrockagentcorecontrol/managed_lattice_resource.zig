const aws = @import("aws");

const EndpointIpAddressType = @import("endpoint_ip_address_type.zig").EndpointIpAddressType;

/// Configuration for a managed VPC Lattice resource. The gateway creates and
/// manages the VPC Lattice resource gateway and resource configuration on your
/// behalf using a service-linked role.
pub const ManagedLatticeResource = struct {
    /// The IP address type for the resource configuration endpoint.
    endpoint_ip_address_type: EndpointIpAddressType,

    /// An intermediate publicly resolvable domain used as the VPC Lattice resource
    /// configuration endpoint. Required when your private endpoint uses a domain
    /// that is not publicly resolvable.
    routing_domain: ?[]const u8 = null,

    /// The security group IDs to associate with the VPC Lattice resource gateway.
    /// If not specified, the default security group for the VPC is used.
    security_group_ids: ?[]const []const u8 = null,

    /// The subnet IDs within the VPC where the VPC Lattice resource gateway is
    /// placed.
    subnet_ids: []const []const u8,

    /// Tags to apply to the managed VPC Lattice resource gateway.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The ID of the VPC that contains your private resource.
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
