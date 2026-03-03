const Ipv6CidrBlockAssociation = @import("ipv_6_cidr_block_association.zig").Ipv6CidrBlockAssociation;

/// Contains information about a subnet in Amazon EC2.
pub const AwsEc2SubnetDetails = struct {
    /// Whether to assign an IPV6 address to a network interface that is created in
    /// this subnet.
    assign_ipv_6_address_on_creation: ?bool = null,

    /// The Availability Zone for the subnet.
    availability_zone: ?[]const u8 = null,

    /// The identifier of the Availability Zone for the subnet.
    availability_zone_id: ?[]const u8 = null,

    /// The number of available IPV4 addresses in the subnet. Does not include
    /// addresses for stopped instances.
    available_ip_address_count: ?i32 = null,

    /// The IPV4 CIDR block that is assigned to the subnet.
    cidr_block: ?[]const u8 = null,

    /// Whether this subnet is the default subnet for the Availability Zone.
    default_for_az: ?bool = null,

    /// The IPV6 CIDR blocks that are associated with the subnet.
    ipv_6_cidr_block_association_set: ?[]const Ipv6CidrBlockAssociation = null,

    /// Whether instances in this subnet receive a public IP address.
    map_public_ip_on_launch: ?bool = null,

    /// The identifier of the Amazon Web Services account that owns the subnet.
    owner_id: ?[]const u8 = null,

    /// The current state of the subnet. Valid values are `available` or `pending`.
    state: ?[]const u8 = null,

    /// The ARN of the subnet.
    subnet_arn: ?[]const u8 = null,

    /// The identifier of the subnet.
    subnet_id: ?[]const u8 = null,

    /// The identifier of the VPC that contains the subnet.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .assign_ipv_6_address_on_creation = "AssignIpv6AddressOnCreation",
        .availability_zone = "AvailabilityZone",
        .availability_zone_id = "AvailabilityZoneId",
        .available_ip_address_count = "AvailableIpAddressCount",
        .cidr_block = "CidrBlock",
        .default_for_az = "DefaultForAz",
        .ipv_6_cidr_block_association_set = "Ipv6CidrBlockAssociationSet",
        .map_public_ip_on_launch = "MapPublicIpOnLaunch",
        .owner_id = "OwnerId",
        .state = "State",
        .subnet_arn = "SubnetArn",
        .subnet_id = "SubnetId",
        .vpc_id = "VpcId",
    };
};
