const AwsEc2LaunchTemplateDataNetworkInterfaceSetIpv4PrefixesDetails = @import("aws_ec_2_launch_template_data_network_interface_set_ipv_4_prefixes_details.zig").AwsEc2LaunchTemplateDataNetworkInterfaceSetIpv4PrefixesDetails;
const AwsEc2LaunchTemplateDataNetworkInterfaceSetIpv6AddressesDetails = @import("aws_ec_2_launch_template_data_network_interface_set_ipv_6_addresses_details.zig").AwsEc2LaunchTemplateDataNetworkInterfaceSetIpv6AddressesDetails;
const AwsEc2LaunchTemplateDataNetworkInterfaceSetIpv6PrefixesDetails = @import("aws_ec_2_launch_template_data_network_interface_set_ipv_6_prefixes_details.zig").AwsEc2LaunchTemplateDataNetworkInterfaceSetIpv6PrefixesDetails;
const AwsEc2LaunchTemplateDataNetworkInterfaceSetPrivateIpAddressesDetails = @import("aws_ec_2_launch_template_data_network_interface_set_private_ip_addresses_details.zig").AwsEc2LaunchTemplateDataNetworkInterfaceSetPrivateIpAddressesDetails;

/// One or more network interfaces to attach to an Amazon EC2 instance. If you
/// specify a network interface, you must specify
/// security groups and subnets as part of the network interface.
pub const AwsEc2LaunchTemplateDataNetworkInterfaceSetDetails = struct {
    /// Indicates whether to associate a Carrier IP address with eth0 for a new
    /// network interface.
    /// You use this option when you launch an instance in a Wavelength Zone and
    /// want to
    /// associate a Carrier IP address with the network interface. For more
    /// information, see
    /// [Carrier IP
    /// address](https://docs.aws.amazon.com/wavelength/latest/developerguide/how-wavelengths-work.html#provider-owned-ip) in the *Wavelength Developer Guide*.
    associate_carrier_ip_address: ?bool = null,

    /// Associates a public IPv4 address with eth0 for a new network interface.
    associate_public_ip_address: ?bool = null,

    /// Indicates whether the network interface is deleted when the instance is
    /// terminated.
    delete_on_termination: ?bool = null,

    /// A description for the network interface.
    description: ?[]const u8 = null,

    /// The device index for the network interface attachment.
    device_index: ?i32 = null,

    /// The IDs of one or more security groups.
    groups: ?[]const []const u8 = null,

    /// The type of network interface.
    interface_type: ?[]const u8 = null,

    /// The number of IPv4 prefixes to be automatically assigned to the network
    /// interface.
    /// You cannot use this option if you use the `Ipv4Prefixes` option.
    ipv_4_prefix_count: ?i32 = null,

    /// One or more IPv4 prefixes to be assigned to the network interface. You
    /// cannot use
    /// this option if you use the `Ipv4PrefixCount` option.
    ipv_4_prefixes: ?[]const AwsEc2LaunchTemplateDataNetworkInterfaceSetIpv4PrefixesDetails = null,

    /// The number of IPv6 addresses to assign to a network interface. Amazon EC2
    /// automatically selects the IPv6 addresses from the subnet range. You can't
    /// use this
    /// option if you use `Ipv6Addresses`.
    ipv_6_address_count: ?i32 = null,

    /// One or more specific IPv6 addresses from the IPv6 CIDR block range of your
    /// subnet.
    /// You can't use this option if you use `Ipv6AddressCount`.
    ipv_6_addresses: ?[]const AwsEc2LaunchTemplateDataNetworkInterfaceSetIpv6AddressesDetails = null,

    /// The number of IPv6 prefixes to be automatically assigned to the network
    /// interface.
    /// You cannot use this option if you use the `Ipv6Prefix` option.
    ipv_6_prefix_count: ?i32 = null,

    /// One or more IPv6 prefixes to be assigned to the network interface. You
    /// cannot use
    /// this option if you use the `Ipv6PrefixCount` option.
    ipv_6_prefixes: ?[]const AwsEc2LaunchTemplateDataNetworkInterfaceSetIpv6PrefixesDetails = null,

    /// The index of the network card. Some instance types support multiple network
    /// cards.
    /// The primary network interface must be assigned to network card index `0`.
    /// The default
    /// is network card index `0`.
    network_card_index: ?i32 = null,

    /// The ID of the network interface.
    network_interface_id: ?[]const u8 = null,

    /// The primary private IPv4 address of the network interface.
    private_ip_address: ?[]const u8 = null,

    /// One or more private IPv4 addresses.
    private_ip_addresses: ?[]const AwsEc2LaunchTemplateDataNetworkInterfaceSetPrivateIpAddressesDetails = null,

    /// The number of secondary private IPv4 addresses to assign to a network
    /// interface.
    secondary_private_ip_address_count: ?i32 = null,

    /// The ID of the subnet for the network interface.
    subnet_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .associate_carrier_ip_address = "AssociateCarrierIpAddress",
        .associate_public_ip_address = "AssociatePublicIpAddress",
        .delete_on_termination = "DeleteOnTermination",
        .description = "Description",
        .device_index = "DeviceIndex",
        .groups = "Groups",
        .interface_type = "InterfaceType",
        .ipv_4_prefix_count = "Ipv4PrefixCount",
        .ipv_4_prefixes = "Ipv4Prefixes",
        .ipv_6_address_count = "Ipv6AddressCount",
        .ipv_6_addresses = "Ipv6Addresses",
        .ipv_6_prefix_count = "Ipv6PrefixCount",
        .ipv_6_prefixes = "Ipv6Prefixes",
        .network_card_index = "NetworkCardIndex",
        .network_interface_id = "NetworkInterfaceId",
        .private_ip_address = "PrivateIpAddress",
        .private_ip_addresses = "PrivateIpAddresses",
        .secondary_private_ip_address_count = "SecondaryPrivateIpAddressCount",
        .subnet_id = "SubnetId",
    };
};
