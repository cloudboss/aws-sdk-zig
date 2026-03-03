const PrivateIp = @import("private_ip.zig").PrivateIp;
const SecurityGroup = @import("security_group.zig").SecurityGroup;

/// Contains information about the network interfaces interacting with an EC2
/// instance.
/// This data type is used as one of the elements of the AssetAttributes data
/// type.
pub const NetworkInterface = struct {
    /// The IP addresses associated with the network interface.
    ipv_6_addresses: ?[]const []const u8 = null,

    /// The ID of the network interface.
    network_interface_id: ?[]const u8 = null,

    /// The name of a private DNS associated with the network interface.
    private_dns_name: ?[]const u8 = null,

    /// The private IP address associated with the network interface.
    private_ip_address: ?[]const u8 = null,

    /// A list of the private IP addresses associated with the network interface.
    /// Includes
    /// the privateDnsName and privateIpAddress.
    private_ip_addresses: ?[]const PrivateIp = null,

    /// The name of a public DNS associated with the network interface.
    public_dns_name: ?[]const u8 = null,

    /// The public IP address from which the network interface is reachable.
    public_ip: ?[]const u8 = null,

    /// A list of the security groups associated with the network interface.
    /// Includes the
    /// groupId and groupName.
    security_groups: ?[]const SecurityGroup = null,

    /// The ID of a subnet associated with the network interface.
    subnet_id: ?[]const u8 = null,

    /// The ID of a VPC associated with the network interface.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .ipv_6_addresses = "ipv6Addresses",
        .network_interface_id = "networkInterfaceId",
        .private_dns_name = "privateDnsName",
        .private_ip_address = "privateIpAddress",
        .private_ip_addresses = "privateIpAddresses",
        .public_dns_name = "publicDnsName",
        .public_ip = "publicIp",
        .security_groups = "securityGroups",
        .subnet_id = "subnetId",
        .vpc_id = "vpcId",
    };
};
