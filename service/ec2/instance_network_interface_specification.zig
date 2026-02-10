const ConnectionTrackingSpecificationRequest = @import("connection_tracking_specification_request.zig").ConnectionTrackingSpecificationRequest;
const EnaSrdSpecificationRequest = @import("ena_srd_specification_request.zig").EnaSrdSpecificationRequest;
const Ipv4PrefixSpecificationRequest = @import("ipv_4_prefix_specification_request.zig").Ipv4PrefixSpecificationRequest;
const InstanceIpv6Address = @import("instance_ipv_6_address.zig").InstanceIpv6Address;
const Ipv6PrefixSpecificationRequest = @import("ipv_6_prefix_specification_request.zig").Ipv6PrefixSpecificationRequest;
const PrivateIpAddressSpecification = @import("private_ip_address_specification.zig").PrivateIpAddressSpecification;

/// Describes a network interface.
pub const InstanceNetworkInterfaceSpecification = struct {
    /// Indicates whether to assign a carrier IP address to the network interface.
    ///
    /// You can only assign a carrier IP address to a network interface that is in a
    /// subnet in
    /// a Wavelength Zone. For more information about carrier IP addresses, see
    /// [Carrier IP
    /// address](https://docs.aws.amazon.com/wavelength/latest/developerguide/how-wavelengths-work.html#provider-owned-ip) in the *Amazon Web Services Wavelength Developer
    /// Guide*.
    associate_carrier_ip_address: ?bool,

    /// Indicates whether to assign a public IPv4 address to an instance you launch
    /// in a VPC.
    /// The public IP address can only be assigned to a network interface for eth0,
    /// and can only
    /// be assigned to a new network interface, not an existing one. You cannot
    /// specify more
    /// than one network interface in the request. If launching into a default
    /// subnet, the
    /// default value is `true`.
    ///
    /// Amazon Web Services charges for all public IPv4 addresses, including public
    /// IPv4 addresses
    /// associated with running instances and Elastic IP addresses. For more
    /// information, see the *Public IPv4 Address* tab on the [Amazon VPC pricing
    /// page](http://aws.amazon.com/vpc/pricing/).
    associate_public_ip_address: ?bool,

    /// A security group connection tracking specification that enables you to set
    /// the timeout
    /// for connection tracking on an Elastic network interface. For more
    /// information, see
    /// [Connection tracking
    /// timeouts](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/security-group-connection-tracking.html#connection-tracking-timeouts) in the
    /// *Amazon EC2 User Guide*.
    connection_tracking_specification: ?ConnectionTrackingSpecificationRequest,

    /// If set to `true`, the interface is deleted when the instance is terminated.
    /// You can specify `true` only if creating a new network interface when
    /// launching an instance.
    delete_on_termination: ?bool,

    /// The description of the network interface. Applies only if creating a network
    /// interface
    /// when launching an instance.
    description: ?[]const u8,

    /// The position of the network interface in the attachment order. A primary
    /// network
    /// interface has a device index of 0.
    ///
    /// If you specify a network interface when launching an instance, you must
    /// specify the
    /// device index.
    device_index: ?i32,

    /// The number of ENA queues to be created with the instance.
    ena_queue_count: ?i32,

    /// Specifies the ENA Express settings for the network interface that's attached
    /// to
    /// the instance.
    ena_srd_specification: ?EnaSrdSpecificationRequest,

    /// The IDs of the security groups for the network interface. Applies only if
    /// creating a
    /// network interface when launching an instance.
    groups: ?[]const []const u8,

    /// The type of network interface.
    ///
    /// If you specify `efa-only`, do not assign any IP addresses to the network
    /// interface. EFA-only network interfaces do not support IP addresses.
    ///
    /// Valid values: `interface` | `efa` | `efa-only`
    interface_type: ?[]const u8,

    /// The number of IPv4 delegated prefixes to be automatically assigned to the
    /// network
    /// interface. You cannot use this option if you use the `Ipv4Prefix`
    /// option.
    ipv_4_prefix_count: ?i32,

    /// The IPv4 delegated prefixes to be assigned to the network interface. You
    /// cannot use
    /// this option if you use the `Ipv4PrefixCount` option.
    ipv_4_prefixes: ?[]const Ipv4PrefixSpecificationRequest,

    /// A number of IPv6 addresses to assign to the network interface. Amazon EC2
    /// chooses the
    /// IPv6 addresses from the range of the subnet. You cannot specify this option
    /// and the
    /// option to assign specific IPv6 addresses in the same request. You can
    /// specify this
    /// option if you've specified a minimum number of instances to launch.
    ipv_6_address_count: ?i32,

    /// The IPv6 addresses to assign to the network interface. You cannot specify
    /// this option
    /// and the option to assign a number of IPv6 addresses in the same request. You
    /// cannot
    /// specify this option if you've specified a minimum number of instances to
    /// launch.
    ipv_6_addresses: ?[]const InstanceIpv6Address,

    /// The number of IPv6 delegated prefixes to be automatically assigned to the
    /// network
    /// interface. You cannot use this option if you use the `Ipv6Prefix`
    /// option.
    ipv_6_prefix_count: ?i32,

    /// The IPv6 delegated prefixes to be assigned to the network interface. You
    /// cannot use
    /// this option if you use the `Ipv6PrefixCount` option.
    ipv_6_prefixes: ?[]const Ipv6PrefixSpecificationRequest,

    /// The index of the network card. Some instance types support multiple network
    /// cards. The
    /// primary network interface must be assigned to network card index 0. The
    /// default is
    /// network card index 0.
    ///
    /// If you are using
    /// [RequestSpotInstances](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RequestSpotInstances.html) to create Spot Instances, omit this parameter because
    /// you can’t specify the network card index when using this API. To specify the
    /// network
    /// card index, use
    /// [RunInstances](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RunInstances.html).
    network_card_index: ?i32,

    /// The ID of the network interface.
    ///
    /// If you are creating a Spot Fleet, omit this parameter because you can’t
    /// specify a
    /// network interface ID in a launch specification.
    network_interface_id: ?[]const u8,

    /// The primary IPv6 address of the network interface. When you enable an IPv6
    /// GUA address to be a primary IPv6, the first IPv6 GUA will be made the
    /// primary IPv6 address until the instance is terminated or the network
    /// interface is detached. For more information about primary IPv6 addresses,
    /// see
    /// [RunInstances](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RunInstances.html).
    primary_ipv_6: ?bool,

    /// The private IPv4 address of the network interface. Applies only if creating
    /// a network
    /// interface when launching an instance. You cannot specify this option if
    /// you're launching
    /// more than one instance in a
    /// [RunInstances](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RunInstances.html)
    /// request.
    private_ip_address: ?[]const u8,

    /// The private IPv4 addresses to assign to the network interface. Only one
    /// private IPv4
    /// address can be designated as primary. You cannot specify this option if
    /// you're launching
    /// more than one instance in a
    /// [RunInstances](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RunInstances.html)
    /// request.
    private_ip_addresses: ?[]const PrivateIpAddressSpecification,

    /// The number of secondary private IPv4 addresses. You can’t specify this
    /// parameter and
    /// also specify a secondary private IP address using the `PrivateIpAddress`
    /// parameter.
    secondary_private_ip_address_count: ?i32,

    /// The ID of the subnet associated with the network interface. Applies only if
    /// creating a
    /// network interface when launching an instance.
    subnet_id: ?[]const u8,
};
