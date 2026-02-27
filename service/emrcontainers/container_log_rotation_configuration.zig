/// The settings for container log rotation.
pub const ContainerLogRotationConfiguration = struct {
    /// The number of files to keep in container after rotation.
    max_files_to_keep: i32,

    /// The file size at which to rotate logs. Minimum of 2KB, Maximum of 2GB.
    rotation_size: []const u8,

    pub const json_field_names = .{
        .max_files_to_keep = "maxFilesToKeep",
        .rotation_size = "rotationSize",
    };
};
