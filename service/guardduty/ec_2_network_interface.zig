const PrivateIpAddressDetails = @import("private_ip_address_details.zig").PrivateIpAddressDetails;
const SecurityGroup = @import("security_group.zig").SecurityGroup;

/// Contains information about the elastic network interface of the Amazon EC2
/// instance.
pub const Ec2NetworkInterface = struct {
    /// A list of IPv6 addresses for the Amazon EC2 instance.
    ipv_6_addresses: ?[]const []const u8,

    /// Other private IP address information of the Amazon EC2 instance.
    private_ip_addresses: ?[]const PrivateIpAddressDetails,

    /// The public IP address of the Amazon EC2 instance.
    public_ip: ?[]const u8,

    /// The security groups associated with the Amazon EC2 instance.
    security_groups: ?[]const SecurityGroup,

    /// The subnet ID of the Amazon EC2 instance.
    sub_net_id: ?[]const u8,

    /// The VPC ID of the Amazon EC2 instance.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .ipv_6_addresses = "Ipv6Addresses",
        .private_ip_addresses = "PrivateIpAddresses",
        .public_ip = "PublicIp",
        .security_groups = "SecurityGroups",
        .sub_net_id = "SubNetId",
        .vpc_id = "VpcId",
    };
};
