const ConnectionTrackingSpecificationRequest = @import("connection_tracking_specification_request.zig").ConnectionTrackingSpecificationRequest;
const EnaSrdSpecificationRequest = @import("ena_srd_specification_request.zig").EnaSrdSpecificationRequest;
const Ipv4PrefixSpecificationRequest = @import("ipv_4_prefix_specification_request.zig").Ipv4PrefixSpecificationRequest;
const InstanceIpv6AddressRequest = @import("instance_ipv_6_address_request.zig").InstanceIpv6AddressRequest;
const Ipv6PrefixSpecificationRequest = @import("ipv_6_prefix_specification_request.zig").Ipv6PrefixSpecificationRequest;
const PrivateIpAddressSpecification = @import("private_ip_address_specification.zig").PrivateIpAddressSpecification;

/// The parameters for a network interface.
pub const LaunchTemplateInstanceNetworkInterfaceSpecificationRequest = struct {
    /// Associates a Carrier IP address with eth0 for a new network interface.
    ///
    /// Use this option when you launch an instance in a Wavelength Zone and want to
    /// associate
    /// a Carrier IP address with the network interface. For more information about
    /// Carrier IP
    /// addresses, see [Carrier IP
    /// addresses](https://docs.aws.amazon.com/wavelength/latest/developerguide/how-wavelengths-work.html#provider-owned-ip) in the *Wavelength Developer
    /// Guide*.
    associate_carrier_ip_address: ?bool = null,

    /// Associates a public IPv4 address with eth0 for a new network interface.
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
    connection_tracking_specification: ?ConnectionTrackingSpecificationRequest = null,

    /// Indicates whether the network interface is deleted when the instance is
    /// terminated.
    delete_on_termination: ?bool = null,

    /// A description for the network interface.
    description: ?[]const u8 = null,

    /// The device index for the network interface attachment. The primary network
    /// interface
    /// has a device index of 0. Each network interface is of type `interface`, you
    /// must specify a device index. If you create a launch template that includes
    /// secondary
    /// network interfaces but not a primary network interface, then you must add a
    /// primary
    /// network interface as a launch parameter when you launch an instance from the
    /// template.
    device_index: ?i32 = null,

    /// The number of ENA queues to be created with the instance.
    ena_queue_count: ?i32 = null,

    /// Configure ENA Express settings for your launch template.
    ena_srd_specification: ?EnaSrdSpecificationRequest = null,

    /// The IDs of one or more security groups.
    groups: ?[]const []const u8 = null,

    /// The type of network interface. To create an Elastic Fabric Adapter (EFA),
    /// specify
    /// `efa` or `efa`. For more information, see [Elastic Fabric Adapter for AI/ML
    /// and HPC workloads on Amazon
    /// EC2](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/efa.html) in the
    /// *Amazon EC2 User Guide*.
    ///
    /// If you are not creating an EFA, specify `interface` or omit this
    /// parameter.
    ///
    /// If you specify `efa-only`, do not assign any IP addresses to the network
    /// interface. EFA-only network interfaces do not support IP addresses.
    ///
    /// Valid values: `interface` | `efa` | `efa-only`
    interface_type: ?[]const u8 = null,

    /// The number of IPv4 prefixes to be automatically assigned to the network
    /// interface. You
    /// cannot use this option if you use the `Ipv4Prefix` option.
    ipv_4_prefix_count: ?i32 = null,

    /// One or more IPv4 prefixes to be assigned to the network interface. You
    /// cannot use this
    /// option if you use the `Ipv4PrefixCount` option.
    ipv_4_prefixes: ?[]const Ipv4PrefixSpecificationRequest = null,

    /// The number of IPv6 addresses to assign to a network interface. Amazon EC2
    /// automatically selects the IPv6 addresses from the subnet range. You can't
    /// use this
    /// option if specifying specific IPv6 addresses.
    ipv_6_address_count: ?i32 = null,

    /// One or more specific IPv6 addresses from the IPv6 CIDR block range of your
    /// subnet. You
    /// can't use this option if you're specifying a number of IPv6 addresses.
    ipv_6_addresses: ?[]const InstanceIpv6AddressRequest = null,

    /// The number of IPv6 prefixes to be automatically assigned to the network
    /// interface. You
    /// cannot use this option if you use the `Ipv6Prefix` option.
    ipv_6_prefix_count: ?i32 = null,

    /// One or more IPv6 prefixes to be assigned to the network interface. You
    /// cannot use this
    /// option if you use the `Ipv6PrefixCount` option.
    ipv_6_prefixes: ?[]const Ipv6PrefixSpecificationRequest = null,

    /// The index of the network card. Some instance types support multiple network
    /// cards. The
    /// primary network interface must be assigned to network card index 0. The
    /// default is
    /// network card index 0.
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

    /// The number of secondary private IPv4 addresses to assign to a network
    /// interface.
    secondary_private_ip_address_count: ?i32 = null,

    /// The ID of the subnet for the network interface.
    subnet_id: ?[]const u8 = null,
};
