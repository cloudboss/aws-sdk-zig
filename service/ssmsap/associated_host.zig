const IpAddressMember = @import("ip_address_member.zig").IpAddressMember;

/// Describes the properties of the associated host.
pub const AssociatedHost = struct {
    /// The ID of the Amazon EC2 instance.
    ec_2_instance_id: ?[]const u8 = null,

    /// The name of the host.
    hostname: ?[]const u8 = null,

    /// The IP addresses of the associated host.
    ip_addresses: ?[]const IpAddressMember = null,

    /// The version of the operating system.
    os_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .ec_2_instance_id = "Ec2InstanceId",
        .hostname = "Hostname",
        .ip_addresses = "IpAddresses",
        .os_version = "OsVersion",
    };
};
