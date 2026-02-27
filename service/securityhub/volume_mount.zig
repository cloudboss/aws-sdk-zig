/// Describes the mounting of a volume in a container.
pub const VolumeMount = struct {
    /// The path in the container at which the volume should be mounted.
    mount_path: ?[]const u8,

    /// The name of the volume.
    name: ?[]const u8,

    pub const json_field_names = .{
        .mount_path = "MountPath",
        .name = "Name",
    };
};
