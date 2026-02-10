const NetworkInterfaceAssociation = @import("network_interface_association.zig").NetworkInterfaceAssociation;
const NetworkInterfaceAttachment = @import("network_interface_attachment.zig").NetworkInterfaceAttachment;
const ConnectionTrackingConfiguration = @import("connection_tracking_configuration.zig").ConnectionTrackingConfiguration;
const GroupIdentifier = @import("group_identifier.zig").GroupIdentifier;
const NetworkInterfaceType = @import("network_interface_type.zig").NetworkInterfaceType;
const Ipv4PrefixSpecification = @import("ipv_4_prefix_specification.zig").Ipv4PrefixSpecification;
const NetworkInterfaceIpv6Address = @import("network_interface_ipv_6_address.zig").NetworkInterfaceIpv6Address;
const Ipv6PrefixSpecification = @import("ipv_6_prefix_specification.zig").Ipv6PrefixSpecification;
const OperatorResponse = @import("operator_response.zig").OperatorResponse;
const NetworkInterfacePrivateIpAddress = @import("network_interface_private_ip_address.zig").NetworkInterfacePrivateIpAddress;
const PublicIpDnsNameOptions = @import("public_ip_dns_name_options.zig").PublicIpDnsNameOptions;
const NetworkInterfaceStatus = @import("network_interface_status.zig").NetworkInterfaceStatus;
const Tag = @import("tag.zig").Tag;

/// Describes a network interface.
pub const NetworkInterface = struct {
    /// The subnets associated with this network interface.
    associated_subnets: ?[]const []const u8,

    /// The association information for an Elastic IP address (IPv4) associated with
    /// the
    /// network interface.
    association: ?NetworkInterfaceAssociation,

    /// The network interface attachment.
    attachment: ?NetworkInterfaceAttachment,

    /// The Availability Zone.
    availability_zone: ?[]const u8,

    /// The ID of the Availability Zone.
    availability_zone_id: ?[]const u8,

    /// A security group connection tracking configuration that enables you to set
    /// the timeout
    /// for connection tracking on an Elastic network interface. For more
    /// information, see
    /// [Connection tracking
    /// timeouts](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/security-group-connection-tracking.html#connection-tracking-timeouts) in the
    /// *Amazon EC2 User Guide*.
    connection_tracking_configuration: ?ConnectionTrackingConfiguration,

    /// Indicates whether a network interface with an IPv6 address is unreachable
    /// from the
    /// public internet. If the value is `true`, inbound traffic from the internet
    /// is
    /// dropped and you cannot assign an elastic IP address to the network
    /// interface. The
    /// network interface is reachable from peered VPCs and resources connected
    /// through a
    /// transit gateway, including on-premises networks.
    deny_all_igw_traffic: ?bool,

    /// A description.
    description: ?[]const u8,

    /// Any security groups for the network interface.
    groups: ?[]const GroupIdentifier,

    /// The type of network interface.
    interface_type: ?NetworkInterfaceType,

    /// The IPv4 prefixes that are assigned to the network interface.
    ipv_4_prefixes: ?[]const Ipv4PrefixSpecification,

    /// The IPv6 globally unique address associated with the network interface.
    ipv_6_address: ?[]const u8,

    /// The IPv6 addresses associated with the network interface.
    ipv_6_addresses: ?[]const NetworkInterfaceIpv6Address,

    /// Indicates whether this is an IPv6 only network interface.
    ipv_6_native: ?bool,

    /// The IPv6 prefixes that are assigned to the network interface.
    ipv_6_prefixes: ?[]const Ipv6PrefixSpecification,

    /// The MAC address.
    mac_address: ?[]const u8,

    /// The ID of the network interface.
    network_interface_id: ?[]const u8,

    /// The service provider that manages the network interface.
    operator: ?OperatorResponse,

    /// The Amazon Resource Name (ARN) of the Outpost.
    outpost_arn: ?[]const u8,

    /// The Amazon Web Services account ID of the owner of the network interface.
    owner_id: ?[]const u8,

    /// The private hostname. For more information, see [EC2 instance hostnames, DNS
    /// names, and
    /// domains](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-naming.html) in the *Amazon EC2 User Guide*.
    private_dns_name: ?[]const u8,

    /// The IPv4 address of the network interface within the subnet.
    private_ip_address: ?[]const u8,

    /// The private IPv4 addresses associated with the network interface.
    private_ip_addresses: ?[]const NetworkInterfacePrivateIpAddress,

    /// A public hostname. For more information, see [EC2 instance hostnames, DNS
    /// names, and
    /// domains](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-naming.html) in the *Amazon EC2 User Guide*.
    public_dns_name: ?[]const u8,

    /// Public hostname type options. For more information, see [EC2 instance
    /// hostnames, DNS names, and
    /// domains](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-naming.html) in the *Amazon EC2 User Guide*.
    public_ip_dns_name_options: ?PublicIpDnsNameOptions,

    /// The alias or Amazon Web Services account ID of the principal or service that
    /// created
    /// the network interface.
    requester_id: ?[]const u8,

    /// Indicates whether the network interface is being managed by Amazon Web
    /// Services.
    requester_managed: ?bool,

    /// Indicates whether source/destination checking is enabled.
    source_dest_check: ?bool,

    /// The status of the network interface.
    status: ?NetworkInterfaceStatus,

    /// The ID of the subnet.
    subnet_id: ?[]const u8,

    /// Any tags assigned to the network interface.
    tag_set: ?[]const Tag,

    /// The ID of the VPC.
    vpc_id: ?[]const u8,
};
