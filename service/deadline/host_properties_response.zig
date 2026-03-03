const IpAddresses = @import("ip_addresses.zig").IpAddresses;

/// The host property details.
pub const HostPropertiesResponse = struct {
    /// The ARN of the host EC2 instance.
    ec_2_instance_arn: ?[]const u8 = null,

    /// The instance type of the host EC2 instance.
    ec_2_instance_type: ?[]const u8 = null,

    /// The host name.
    host_name: ?[]const u8 = null,

    /// The IP address of the host.
    ip_addresses: ?IpAddresses = null,

    pub const json_field_names = .{
        .ec_2_instance_arn = "ec2InstanceArn",
        .ec_2_instance_type = "ec2InstanceType",
        .host_name = "hostName",
        .ip_addresses = "ipAddresses",
    };
};
