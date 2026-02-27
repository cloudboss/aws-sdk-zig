/// Information about a bind mount host volume.
pub const AwsEcsTaskDefinitionVolumesHostDetails = struct {
    /// The path on the host container instance that is presented to the container.
    source_path: ?[]const u8,

    pub const json_field_names = .{
        .source_path = "SourcePath",
    };
};
