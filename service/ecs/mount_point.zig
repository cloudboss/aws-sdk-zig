/// The details for a volume mount point that's used in a container definition.
pub const MountPoint = struct {
    /// The path on the container to mount the host volume at.
    container_path: ?[]const u8 = null,

    /// If this value is `true`, the container has read-only access to the volume.
    /// If this value is `false`, then the container can write to the volume. The
    /// default value is `false`.
    read_only: ?bool = null,

    /// The name of the volume to mount. Must be a volume name referenced in the
    /// `name` parameter of task definition `volume`.
    source_volume: ?[]const u8 = null,

    pub const json_field_names = .{
        .container_path = "containerPath",
        .read_only = "readOnly",
        .source_volume = "sourceVolume",
    };
};
