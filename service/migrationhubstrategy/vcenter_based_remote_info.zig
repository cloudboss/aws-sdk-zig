const OSType = @import("os_type.zig").OSType;

/// Details about the server in vCenter.
pub const VcenterBasedRemoteInfo = struct {
    /// The type of the operating system.
    os_type: ?OSType,

    /// The time when the remote server based on vCenter was last configured.
    vcenter_configuration_time_stamp: ?[]const u8,

    pub const json_field_names = .{
        .os_type = "osType",
        .vcenter_configuration_time_stamp = "vcenterConfigurationTimeStamp",
    };
};
