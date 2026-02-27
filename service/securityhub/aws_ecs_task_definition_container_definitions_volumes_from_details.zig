/// A data volume to mount from another container.
pub const AwsEcsTaskDefinitionContainerDefinitionsVolumesFromDetails = struct {
    /// Whether the container has read-only access to the volume.
    read_only: ?bool,

    /// The name of another container within the same task definition from which to
    /// mount volumes.
    source_container: ?[]const u8,

    pub const json_field_names = .{
        .read_only = "ReadOnly",
        .source_container = "SourceContainer",
    };
};
