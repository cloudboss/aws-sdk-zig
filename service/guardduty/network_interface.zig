const PrivateIpAddressDetails = @import("private_ip_address_details.zig").PrivateIpAddressDetails;
const SecurityGroup = @import("security_group.zig").SecurityGroup;

/// Contains information about the elastic network interface of the EC2
/// instance.
pub const NetworkInterface = struct {
    /// A list of IPv6 addresses for the EC2 instance.
    ipv_6_addresses: ?[]const []const u8 = null,

    /// The ID of the network interface.
    network_interface_id: ?[]const u8 = null,

    /// The private DNS name of the EC2 instance.
    private_dns_name: ?[]const u8 = null,

    /// The private IP address of the EC2 instance.
    private_ip_address: ?[]const u8 = null,

    /// Other private IP address information of the EC2 instance.
    private_ip_addresses: ?[]const PrivateIpAddressDetails = null,

    /// The public DNS name of the EC2 instance.
    public_dns_name: ?[]const u8 = null,

    /// The public IP address of the EC2 instance.
    public_ip: ?[]const u8 = null,

    /// The security groups associated with the EC2 instance.
    security_groups: ?[]const SecurityGroup = null,

    /// The subnet ID of the EC2 instance.
    subnet_id: ?[]const u8 = null,

    /// The VPC ID of the EC2 instance.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .ipv_6_addresses = "Ipv6Addresses",
        .network_interface_id = "NetworkInterfaceId",
        .private_dns_name = "PrivateDnsName",
        .private_ip_address = "PrivateIpAddress",
        .private_ip_addresses = "PrivateIpAddresses",
        .public_dns_name = "PublicDnsName",
        .public_ip = "PublicIp",
        .security_groups = "SecurityGroups",
        .subnet_id = "SubnetId",
        .vpc_id = "VpcId",
    };
};
