const AwsEc2NetworkInterfaceAttachment = @import("aws_ec_2_network_interface_attachment.zig").AwsEc2NetworkInterfaceAttachment;
const AwsEc2NetworkInterfaceIpV6AddressDetail = @import("aws_ec_2_network_interface_ip_v6_address_detail.zig").AwsEc2NetworkInterfaceIpV6AddressDetail;
const AwsEc2NetworkInterfacePrivateIpAddressDetail = @import("aws_ec_2_network_interface_private_ip_address_detail.zig").AwsEc2NetworkInterfacePrivateIpAddressDetail;
const AwsEc2NetworkInterfaceSecurityGroup = @import("aws_ec_2_network_interface_security_group.zig").AwsEc2NetworkInterfaceSecurityGroup;

/// Details about the network interface
pub const AwsEc2NetworkInterfaceDetails = struct {
    /// The network interface attachment.
    attachment: ?AwsEc2NetworkInterfaceAttachment,

    /// The IPv6 addresses associated with the network interface.
    ip_v6_addresses: ?[]const AwsEc2NetworkInterfaceIpV6AddressDetail,

    /// The ID of the network interface.
    network_interface_id: ?[]const u8,

    /// The private IPv4 addresses associated with the network interface.
    private_ip_addresses: ?[]const AwsEc2NetworkInterfacePrivateIpAddressDetail,

    /// The public DNS name of the network interface.
    public_dns_name: ?[]const u8,

    /// The address of the Elastic IP address bound to the network interface.
    public_ip: ?[]const u8,

    /// Security groups for the network interface.
    security_groups: ?[]const AwsEc2NetworkInterfaceSecurityGroup,

    /// Indicates whether traffic to or from the instance is validated.
    source_dest_check: ?bool,

    pub const json_field_names = .{
        .attachment = "Attachment",
        .ip_v6_addresses = "IpV6Addresses",
        .network_interface_id = "NetworkInterfaceId",
        .private_ip_addresses = "PrivateIpAddresses",
        .public_dns_name = "PublicDnsName",
        .public_ip = "PublicIp",
        .security_groups = "SecurityGroups",
        .source_dest_check = "SourceDestCheck",
    };
};
