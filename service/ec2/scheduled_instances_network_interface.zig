const ScheduledInstancesIpv6Address = @import("scheduled_instances_ipv_6_address.zig").ScheduledInstancesIpv6Address;
const ScheduledInstancesPrivateIpAddressConfig = @import("scheduled_instances_private_ip_address_config.zig").ScheduledInstancesPrivateIpAddressConfig;

/// Describes a network interface for a Scheduled Instance.
pub const ScheduledInstancesNetworkInterface = struct {
    /// Indicates whether to assign a public IPv4 address to instances launched in a
    /// VPC. The
    /// public IPv4 address can only be assigned to a network interface for eth0,
    /// and can only be
    /// assigned to a new network interface, not an existing one. You cannot specify
    /// more than one
    /// network interface in the request. If launching into a default subnet, the
    /// default value is
    /// `true`.
    ///
    /// Amazon Web Services charges for all public IPv4 addresses, including public
    /// IPv4 addresses
    /// associated with running instances and Elastic IP addresses. For more
    /// information, see the *Public IPv4 Address* tab on the [Amazon VPC pricing
    /// page](http://aws.amazon.com/vpc/pricing/).
    associate_public_ip_address: ?bool,

    /// Indicates whether to delete the interface when the instance is terminated.
    delete_on_termination: ?bool,

    /// The description.
    description: ?[]const u8,

    /// The index of the device for the network interface attachment.
    device_index: ?i32,

    /// The IDs of the security groups.
    groups: ?[]const []const u8,

    /// The number of IPv6 addresses to assign to the network interface. The IPv6
    /// addresses are automatically selected from the subnet range.
    ipv_6_address_count: ?i32,

    /// The specific IPv6 addresses from the subnet range.
    ipv_6_addresses: ?[]const ScheduledInstancesIpv6Address,

    /// The ID of the network interface.
    network_interface_id: ?[]const u8,

    /// The IPv4 address of the network interface within the subnet.
    private_ip_address: ?[]const u8,

    /// The private IPv4 addresses.
    private_ip_address_configs: ?[]const ScheduledInstancesPrivateIpAddressConfig,

    /// The number of secondary private IPv4 addresses.
    secondary_private_ip_address_count: ?i32,

    /// The ID of the subnet.
    subnet_id: ?[]const u8,
};
