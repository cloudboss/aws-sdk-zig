const DeviceCgroupPermission = @import("device_cgroup_permission.zig").DeviceCgroupPermission;

/// An object that represents a container instance host device.
///
/// This object isn't applicable to jobs that are running on Fargate resources
/// and shouldn't
/// be provided.
pub const Device = struct {
    /// The path inside the container that's used to expose the host device. By
    /// default, the
    /// `hostPath` value is used.
    container_path: ?[]const u8,

    /// The path for the device on the host container instance.
    host_path: []const u8,

    /// The explicit permissions to provide to the container for the device. By
    /// default, the
    /// container has permissions for `read`, `write`, and `mknod` for
    /// the device.
    permissions: ?[]const DeviceCgroupPermission,

    pub const json_field_names = .{
        .container_path = "containerPath",
        .host_path = "hostPath",
        .permissions = "permissions",
    };
};
