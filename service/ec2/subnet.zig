const BlockPublicAccessStates = @import("block_public_access_states.zig").BlockPublicAccessStates;
const SubnetIpv6CidrBlockAssociation = @import("subnet_ipv_6_cidr_block_association.zig").SubnetIpv6CidrBlockAssociation;
const PrivateDnsNameOptionsOnLaunch = @import("private_dns_name_options_on_launch.zig").PrivateDnsNameOptionsOnLaunch;
const SubnetState = @import("subnet_state.zig").SubnetState;
const Tag = @import("tag.zig").Tag;

/// Describes a subnet.
pub const Subnet = struct {
    /// Indicates whether a network interface created in this subnet (including a
    /// network
    /// interface created by RunInstances) receives an IPv6 address.
    assign_ipv_6_address_on_creation: ?bool,

    /// The Availability Zone of the subnet.
    availability_zone: ?[]const u8,

    /// The AZ ID of the subnet.
    availability_zone_id: ?[]const u8,

    /// The number of unused private IPv4 addresses in the subnet. The IPv4
    /// addresses for any
    /// stopped instances are considered unavailable.
    available_ip_address_count: ?i32,

    /// The state of VPC Block Public Access (BPA).
    block_public_access_states: ?BlockPublicAccessStates,

    /// The IPv4 CIDR block assigned to the subnet.
    cidr_block: ?[]const u8,

    /// The customer-owned IPv4 address pool associated with the subnet.
    customer_owned_ipv_4_pool: ?[]const u8,

    /// Indicates whether this is the default subnet for the Availability Zone.
    default_for_az: ?bool,

    /// Indicates whether DNS queries made to the Amazon-provided DNS Resolver in
    /// this subnet
    /// should return synthetic IPv6 addresses for IPv4-only destinations.
    enable_dns_64: ?bool,

    /// Indicates the device position for local network interfaces in this subnet.
    /// For example,
    /// `1` indicates local network interfaces in this subnet are the secondary
    /// network interface (eth1).
    enable_lni_at_device_index: ?i32,

    /// Information about the IPv6 CIDR blocks associated with the subnet.
    ipv_6_cidr_block_association_set: ?[]const SubnetIpv6CidrBlockAssociation,

    /// Indicates whether this is an IPv6 only subnet.
    ipv_6_native: ?bool,

    /// Indicates whether a network interface created in this subnet (including a
    /// network
    /// interface created by RunInstances) receives a customer-owned IPv4 address.
    map_customer_owned_ip_on_launch: ?bool,

    /// Indicates whether instances launched in this subnet receive a public IPv4
    /// address.
    ///
    /// Amazon Web Services charges for all public IPv4 addresses, including public
    /// IPv4 addresses
    /// associated with running instances and Elastic IP addresses. For more
    /// information, see the *Public IPv4 Address* tab on the [Amazon VPC pricing
    /// page](http://aws.amazon.com/vpc/pricing/).
    map_public_ip_on_launch: ?bool,

    /// The Amazon Resource Name (ARN) of the Outpost.
    outpost_arn: ?[]const u8,

    /// The ID of the Amazon Web Services account that owns the subnet.
    owner_id: ?[]const u8,

    /// The type of hostnames to assign to instances in the subnet at launch. An
    /// instance hostname
    /// is based on the IPv4 address or ID of the instance.
    private_dns_name_options_on_launch: ?PrivateDnsNameOptionsOnLaunch,

    /// The current state of the subnet.
    ///
    /// * `failed`: The underlying infrastructure to support the subnet failed to
    ///   provision
    /// as expected.
    ///
    /// * `failed-insufficient-capacity`: The underlying infrastructure to support
    ///   the subnet
    /// failed to provision due to a shortage of EC2 instance capacity.
    state: ?SubnetState,

    /// The Amazon Resource Name (ARN) of the subnet.
    subnet_arn: ?[]const u8,

    /// The ID of the subnet.
    subnet_id: ?[]const u8,

    /// Any tags assigned to the subnet.
    tags: ?[]const Tag,

    /// Indicates if this is a subnet used with Amazon Elastic VMware Service (EVS).
    /// Possible values are `Elastic VMware Service` or no value. For more
    /// information about Amazon EVS, see [
    /// *Amazon Elastic VMware Service
    /// API Reference*
    /// ](https://docs.aws.amazon.com/evs/latest/APIReference/Welcome.html).
    @"type": ?[]const u8,

    /// The ID of the VPC the subnet is in.
    vpc_id: ?[]const u8,
};
