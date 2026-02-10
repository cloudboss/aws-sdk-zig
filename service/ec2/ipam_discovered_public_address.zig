const IpamPublicAddressType = @import("ipam_public_address_type.zig").IpamPublicAddressType;
const IpamPublicAddressAssociationStatus = @import("ipam_public_address_association_status.zig").IpamPublicAddressAssociationStatus;
const IpamPublicAddressSecurityGroup = @import("ipam_public_address_security_group.zig").IpamPublicAddressSecurityGroup;
const IpamPublicAddressAwsService = @import("ipam_public_address_aws_service.zig").IpamPublicAddressAwsService;
const IpamPublicAddressTags = @import("ipam_public_address_tags.zig").IpamPublicAddressTags;

/// A public IP Address discovered by IPAM.
pub const IpamDiscoveredPublicAddress = struct {
    /// The IP address.
    address: ?[]const u8,

    /// The allocation ID of the resource the IP address is assigned to.
    address_allocation_id: ?[]const u8,

    /// The ID of the owner of the resource the IP address is assigned to.
    address_owner_id: ?[]const u8,

    /// The Region of the resource the IP address is assigned to.
    address_region: ?[]const u8,

    /// The IP address type.
    address_type: ?IpamPublicAddressType,

    /// The association status.
    association_status: ?IpamPublicAddressAssociationStatus,

    /// The instance ID of the instance the assigned IP address is assigned to.
    instance_id: ?[]const u8,

    /// The resource discovery ID.
    ipam_resource_discovery_id: ?[]const u8,

    /// The Availability Zone (AZ) or Local Zone (LZ) network border group that the
    /// resource that the IP address is assigned to is in. Defaults to an AZ network
    /// border group. For more information on available Local Zones, see [Local Zone
    /// availability](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-byoip.html#byoip-zone-avail) in the *Amazon EC2 User Guide*.
    network_border_group: ?[]const u8,

    /// The description of the network interface that IP address is assigned to.
    network_interface_description: ?[]const u8,

    /// The network interface ID of the resource with the assigned IP address.
    network_interface_id: ?[]const u8,

    /// The ID of the public IPv4 pool that the resource with the assigned IP
    /// address is from.
    public_ipv_4_pool_id: ?[]const u8,

    /// The last successful resource discovery time.
    sample_time: ?i64,

    /// Security groups associated with the resource that the IP address is assigned
    /// to.
    security_groups: ?[]const IpamPublicAddressSecurityGroup,

    /// The Amazon Web Services service associated with the IP address.
    service: ?IpamPublicAddressAwsService,

    /// The resource ARN or ID.
    service_resource: ?[]const u8,

    /// The ID of the subnet that the resource with the assigned IP address is in.
    subnet_id: ?[]const u8,

    /// Tags associated with the IP address.
    tags: ?IpamPublicAddressTags,

    /// The ID of the VPC that the resource with the assigned IP address is in.
    vpc_id: ?[]const u8,
};
