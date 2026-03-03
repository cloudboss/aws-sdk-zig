const ConnectionTrackingSpecification = @import("connection_tracking_specification.zig").ConnectionTrackingSpecification;
const LaunchTemplateEnaSrdSpecification = @import("launch_template_ena_srd_specification.zig").LaunchTemplateEnaSrdSpecification;
const Ipv4PrefixSpecificationResponse = @import("ipv_4_prefix_specification_response.zig").Ipv4PrefixSpecificationResponse;
const InstanceIpv6Address = @import("instance_ipv_6_address.zig").InstanceIpv6Address;
const Ipv6PrefixSpecificationResponse = @import("ipv_6_prefix_specification_response.zig").Ipv6PrefixSpecificationResponse;
const PrivateIpAddressSpecification = @import("private_ip_address_specification.zig").PrivateIpAddressSpecification;

/// Describes a network interface.
pub const LaunchTemplateInstanceNetworkInterfaceSpecification = struct {
    /// Indicates whether to associate a Carrier IP address with eth0 for a new
    /// network
    /// interface.
    ///
    /// Use this option when you launch an instance in a Wavelength Zone and want to
    /// associate
    /// a Carrier IP address with the network interface. For more information about
    /// Carrier IP
    /// addresses, see [Carrier IP
    /// address](https://docs.aws.amazon.com/wavelength/latest/developerguide/how-wavelengths-work.html#provider-owned-ip) in the *Wavelength Developer
    /// Guide*.
    associate_carrier_ip_address: ?bool = null,

    /// Indicates whether to associate a public IPv4 address with eth0 for a new
    /// network
    /// interface.
    ///
    /// Amazon Web Services charges for all public IPv4 addresses, including public
    /// IPv4 addresses
    /// associated with running instances and Elastic IP addresses. For more
    /// information, see the *Public IPv4 Address* tab on the [Amazon VPC pricing
    /// page](http://aws.amazon.com/vpc/pricing/).
    associate_public_ip_address: ?bool = null,

    /// A security group connection tracking specification that enables you to set
    /// the timeout
    /// for connection tracking on an Elastic network interface. For more
    /// information, see
    /// [Idle connection tracking
    /// timeout](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/security-group-connection-tracking.html#connection-tracking-timeouts) in the
    /// *Amazon EC2 User Guide*.
    connection_tracking_specification: ?ConnectionTrackingSpecification = null,

    /// Indicates whether the network interface is deleted when the instance is
    /// terminated.
    delete_on_termination: ?bool = null,

    /// A description for the network interface.
    description: ?[]const u8 = null,

    /// The device index for the network interface attachment.
    device_index: ?i32 = null,

    /// The number of ENA queues created with the instance.
    ena_queue_count: ?i32 = null,

    /// Contains the ENA Express settings for instances launched from your launch
    /// template.
    ena_srd_specification: ?LaunchTemplateEnaSrdSpecification = null,

    /// The IDs of one or more security groups.
    groups: ?[]const []const u8 = null,

    /// The type of network interface.
    interface_type: ?[]const u8 = null,

    /// The number of IPv4 prefixes that Amazon Web Services automatically assigned
    /// to the network
    /// interface.
    ipv_4_prefix_count: ?i32 = null,

    /// One or more IPv4 prefixes assigned to the network interface.
    ipv_4_prefixes: ?[]const Ipv4PrefixSpecificationResponse = null,

    /// The number of IPv6 addresses for the network interface.
    ipv_6_address_count: ?i32 = null,

    /// The IPv6 addresses for the network interface.
    ipv_6_addresses: ?[]const InstanceIpv6Address = null,

    /// The number of IPv6 prefixes that Amazon Web Services automatically assigned
    /// to the network
    /// interface.
    ipv_6_prefix_count: ?i32 = null,

    /// One or more IPv6 prefixes assigned to the network interface.
    ipv_6_prefixes: ?[]const Ipv6PrefixSpecificationResponse = null,

    /// The index of the network card.
    network_card_index: ?i32 = null,

    /// The ID of the network interface.
    network_interface_id: ?[]const u8 = null,

    /// The primary IPv6 address of the network interface. When you enable an IPv6
    /// GUA address
    /// to be a primary IPv6, the first IPv6 GUA will be made the primary IPv6
    /// address until the
    /// instance is terminated or the network interface is detached. For more
    /// information about
    /// primary IPv6 addresses, see
    /// [RunInstances](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RunInstances.html).
    primary_ipv_6: ?bool = null,

    /// The primary private IPv4 address of the network interface.
    private_ip_address: ?[]const u8 = null,

    /// One or more private IPv4 addresses.
    private_ip_addresses: ?[]const PrivateIpAddressSpecification = null,

    /// The number of secondary private IPv4 addresses for the network interface.
    secondary_private_ip_address_count: ?i32 = null,

    /// The ID of the subnet for the network interface.
    subnet_id: ?[]const u8 = null,
};
