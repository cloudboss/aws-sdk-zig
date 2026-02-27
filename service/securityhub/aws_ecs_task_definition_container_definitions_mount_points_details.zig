/// A mount point for the data volumes in the container.
pub const AwsEcsTaskDefinitionContainerDefinitionsMountPointsDetails = struct {
    /// The path on the container to mount the host volume at.
    container_path: ?[]const u8,

    /// Whether the container has read-only access to the volume.
    read_only: ?bool,

    /// The name of the volume to mount. Must match the name of a volume listed in
    /// `VolumeDetails` for the task definition.
    source_volume: ?[]const u8,

    pub const json_field_names = .{
        .container_path = "ContainerPath",
        .read_only = "ReadOnly",
        .source_volume = "SourceVolume",
    };
};
