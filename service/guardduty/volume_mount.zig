/// Container volume mount.
pub const VolumeMount = struct {
    /// Volume mount path.
    mount_path: ?[]const u8,

    /// Volume mount name.
    name: ?[]const u8,

    pub const json_field_names = .{
        .mount_path = "MountPath",
        .name = "Name",
    };
};
