const DeviceCgroupPermission = @import("device_cgroup_permission.zig").DeviceCgroupPermission;

/// An object representing a container instance host device.
pub const Device = struct {
    /// The path inside the container at which to expose the host device.
    container_path: ?[]const u8 = null,

    /// The path for the device on the host container instance.
    host_path: []const u8,

    /// The explicit permissions to provide to the container for the device. By
    /// default, the
    /// container has permissions for `read`, `write`, and
    /// `mknod` for the device.
    permissions: ?[]const DeviceCgroupPermission = null,

    pub const json_field_names = .{
        .container_path = "containerPath",
        .host_path = "hostPath",
        .permissions = "permissions",
    };
};
