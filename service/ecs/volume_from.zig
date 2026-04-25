/// Details on a data volume from another container in the same task definition.
pub const VolumeFrom = struct {
    /// If this value is `true`, the container has read-only access to the volume.
    /// If this value is `false`, then the container can write to the volume. The
    /// default value is `false`.
    read_only: ?bool = null,

    /// The name of another container within the same task definition to mount
    /// volumes from.
    source_container: ?[]const u8 = null,

    pub const json_field_names = .{
        .read_only = "readOnly",
        .source_container = "sourceContainer",
    };
};
