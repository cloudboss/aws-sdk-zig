const InstanceNetworkInterfaceAssociation = @import("instance_network_interface_association.zig").InstanceNetworkInterfaceAssociation;
const InstanceNetworkInterfaceAttachment = @import("instance_network_interface_attachment.zig").InstanceNetworkInterfaceAttachment;
const ConnectionTrackingSpecificationResponse = @import("connection_tracking_specification_response.zig").ConnectionTrackingSpecificationResponse;
const GroupIdentifier = @import("group_identifier.zig").GroupIdentifier;
const InstanceIpv4Prefix = @import("instance_ipv_4_prefix.zig").InstanceIpv4Prefix;
const InstanceIpv6Address = @import("instance_ipv_6_address.zig").InstanceIpv6Address;
const InstanceIpv6Prefix = @import("instance_ipv_6_prefix.zig").InstanceIpv6Prefix;
const OperatorResponse = @import("operator_response.zig").OperatorResponse;
const InstancePrivateIpAddress = @import("instance_private_ip_address.zig").InstancePrivateIpAddress;
const NetworkInterfaceStatus = @import("network_interface_status.zig").NetworkInterfaceStatus;

/// Describes a network interface.
pub const InstanceNetworkInterface = struct {
    /// The association information for an Elastic IPv4 associated with the network
    /// interface.
    association: ?InstanceNetworkInterfaceAssociation = null,

    /// The network interface attachment.
    attachment: ?InstanceNetworkInterfaceAttachment = null,

    /// A security group connection tracking configuration that enables you to set
    /// the timeout
    /// for connection tracking on an Elastic network interface. For more
    /// information, see
    /// [Connection tracking
    /// timeouts](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/security-group-connection-tracking.html#connection-tracking-timeouts) in the
    /// *Amazon EC2 User Guide*.
    connection_tracking_configuration: ?ConnectionTrackingSpecificationResponse = null,

    /// The description.
    description: ?[]const u8 = null,

    /// The security groups.
    groups: ?[]const GroupIdentifier = null,

    /// The type of network interface.
    ///
    /// Valid values: `interface` | `efa` | `efa-only` | `evs` |
    /// `trunk`
    interface_type: ?[]const u8 = null,

    /// The IPv4 delegated prefixes that are assigned to the network interface.
    ipv_4_prefixes: ?[]const InstanceIpv4Prefix = null,

    /// The IPv6 addresses associated with the network interface.
    ipv_6_addresses: ?[]const InstanceIpv6Address = null,

    /// The IPv6 delegated prefixes that are assigned to the network interface.
    ipv_6_prefixes: ?[]const InstanceIpv6Prefix = null,

    /// The MAC address.
    mac_address: ?[]const u8 = null,

    /// The ID of the network interface.
    network_interface_id: ?[]const u8 = null,

    /// The service provider that manages the network interface.
    operator: ?OperatorResponse = null,

    /// The ID of the Amazon Web Services account that created the network
    /// interface.
    owner_id: ?[]const u8 = null,

    /// The private DNS name.
    private_dns_name: ?[]const u8 = null,

    /// The IPv4 address of the network interface within the subnet.
    private_ip_address: ?[]const u8 = null,

    /// The private IPv4 addresses associated with the network interface.
    private_ip_addresses: ?[]const InstancePrivateIpAddress = null,

    /// Indicates whether source/destination checking is enabled.
    source_dest_check: ?bool = null,

    /// The status of the network interface.
    status: ?NetworkInterfaceStatus = null,

    /// The ID of the subnet.
    subnet_id: ?[]const u8 = null,

    /// The ID of the VPC.
    vpc_id: ?[]const u8 = null,
};
