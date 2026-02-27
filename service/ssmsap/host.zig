const HostRole = @import("host_role.zig").HostRole;

/// Describes the properties of the Dedicated Host.
pub const Host = struct {
    /// The ID of Amazon EC2 instance.
    ec2_instance_id: ?[]const u8,

    /// The IP address of the Dedicated Host.
    host_ip: ?[]const u8,

    /// The name of the Dedicated Host.
    host_name: ?[]const u8,

    /// The role of the Dedicated Host.
    host_role: ?HostRole,

    /// The instance ID of the instance on the Dedicated Host.
    instance_id: ?[]const u8,

    /// The version of the operating system.
    os_version: ?[]const u8,

    pub const json_field_names = .{
        .ec2_instance_id = "EC2InstanceId",
        .host_ip = "HostIp",
        .host_name = "HostName",
        .host_role = "HostRole",
        .instance_id = "InstanceId",
        .os_version = "OsVersion",
    };
};
