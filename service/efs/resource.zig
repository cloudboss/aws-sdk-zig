/// An EFS resource, for example a file system or a mount target.
pub const Resource = enum {
    file_system,
    mount_target,

    pub const json_field_names = .{
        .file_system = "FileSystem",
        .mount_target = "MountTarget",
    };
};
