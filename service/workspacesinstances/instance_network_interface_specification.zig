const ConnectionTrackingSpecificationRequest = @import("connection_tracking_specification_request.zig").ConnectionTrackingSpecificationRequest;
const EnaSrdSpecificationRequest = @import("ena_srd_specification_request.zig").EnaSrdSpecificationRequest;
const InterfaceTypeEnum = @import("interface_type_enum.zig").InterfaceTypeEnum;
const Ipv4PrefixSpecificationRequest = @import("ipv_4_prefix_specification_request.zig").Ipv4PrefixSpecificationRequest;
const InstanceIpv6Address = @import("instance_ipv_6_address.zig").InstanceIpv6Address;
const Ipv6PrefixSpecificationRequest = @import("ipv_6_prefix_specification_request.zig").Ipv6PrefixSpecificationRequest;
const PrivateIpAddressSpecification = @import("private_ip_address_specification.zig").PrivateIpAddressSpecification;

/// Defines network interface configuration for WorkSpace Instance.
pub const InstanceNetworkInterfaceSpecification = struct {
    /// Enables carrier IP address association.
    associate_carrier_ip_address: ?bool,

    /// Enables public IP address assignment.
    associate_public_ip_address: ?bool,

    /// Configures network connection tracking parameters.
    connection_tracking_specification: ?ConnectionTrackingSpecificationRequest,

    /// Descriptive text for the network interface.
    description: ?[]const u8,

    /// Unique index for the network interface.
    device_index: ?i32,

    /// Configures Elastic Network Adapter Scalable Reliable Datagram settings.
    ena_srd_specification: ?EnaSrdSpecificationRequest,

    /// Security groups associated with the network interface.
    groups: ?[]const []const u8,

    /// Specifies the type of network interface.
    interface_type: ?InterfaceTypeEnum,

    /// Number of IPv4 prefixes to assign.
    ipv_4_prefix_count: ?i32,

    /// IPv4 prefix configurations for the interface.
    ipv_4_prefixes: ?[]const Ipv4PrefixSpecificationRequest,

    /// Number of IPv6 addresses to assign.
    ipv_6_address_count: ?i32,

    /// Specific IPv6 addresses for the interface.
    ipv_6_addresses: ?[]const InstanceIpv6Address,

    /// Number of IPv6 prefixes to assign.
    ipv_6_prefix_count: ?i32,

    /// IPv6 prefix configurations for the interface.
    ipv_6_prefixes: ?[]const Ipv6PrefixSpecificationRequest,

    /// Index of the network card for multiple network interfaces.
    network_card_index: ?i32,

    /// Unique identifier for the network interface.
    network_interface_id: ?[]const u8,

    /// Indicates the primary IPv6 configuration.
    primary_ipv_6: ?bool,

    /// Primary private IP address for the interface.
    private_ip_address: ?[]const u8,

    /// List of private IP addresses for the interface.
    private_ip_addresses: ?[]const PrivateIpAddressSpecification,

    /// Number of additional private IP addresses to assign.
    secondary_private_ip_address_count: ?i32,

    /// Subnet identifier for the network interface.
    subnet_id: ?[]const u8,

    pub const json_field_names = .{
        .associate_carrier_ip_address = "AssociateCarrierIpAddress",
        .associate_public_ip_address = "AssociatePublicIpAddress",
        .connection_tracking_specification = "ConnectionTrackingSpecification",
        .description = "Description",
        .device_index = "DeviceIndex",
        .ena_srd_specification = "EnaSrdSpecification",
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
        .primary_ipv_6 = "PrimaryIpv6",
        .private_ip_address = "PrivateIpAddress",
        .private_ip_addresses = "PrivateIpAddresses",
        .secondary_private_ip_address_count = "SecondaryPrivateIpAddressCount",
        .subnet_id = "SubnetId",
    };
};
