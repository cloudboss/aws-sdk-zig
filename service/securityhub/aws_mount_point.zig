/// Details for a volume mount point that's used in a container definition.
pub const AwsMountPoint = struct {
    /// The path on the container to mount the host volume at.
    container_path: ?[]const u8 = null,

    /// The name of the volume to mount. Must be a volume name referenced in the
    /// `name` parameter
    /// of task definition `volume`.
    source_volume: ?[]const u8 = null,

    pub const json_field_names = .{
        .container_path = "ContainerPath",
        .source_volume = "SourceVolume",
    };
};
