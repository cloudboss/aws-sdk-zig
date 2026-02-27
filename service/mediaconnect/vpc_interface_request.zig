const aws = @import("aws");

const NetworkInterfaceType = @import("network_interface_type.zig").NetworkInterfaceType;

/// The details of the VPC interfaces that you want to add to the flow.
pub const VpcInterfaceRequest = struct {
    /// The name for the VPC interface. This name must be unique within the flow.
    name: []const u8,

    /// The type of network interface.
    network_interface_type: ?NetworkInterfaceType,

    /// The Amazon Resource Name (ARN) of the role that you created when you set up
    /// MediaConnect as a trusted service.
    role_arn: []const u8,

    /// A virtual firewall to control inbound and outbound traffic.
    security_group_ids: []const []const u8,

    /// The subnet IDs that you want to use for your VPC interface. A range of IP
    /// addresses in your VPC. When you create your VPC, you specify a range of IPv4
    /// addresses for the VPC in the form of a Classless Inter-Domain Routing (CIDR)
    /// block; for example, 10.0.0.0/16. This is the primary CIDR block for your
    /// VPC. When you create a subnet for your VPC, you specify the CIDR block for
    /// the subnet, which is a subset of the VPC CIDR block. The subnets that you
    /// use across all VPC interfaces on the flow must be in the same Availability
    /// Zone as the flow.
    subnet_id: []const u8,

    /// The key-value pairs that can be used to tag and organize the VPC network
    /// interface.
    vpc_interface_tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .name = "Name",
        .network_interface_type = "NetworkInterfaceType",
        .role_arn = "RoleArn",
        .security_group_ids = "SecurityGroupIds",
        .subnet_id = "SubnetId",
        .vpc_interface_tags = "VpcInterfaceTags",
    };
};
