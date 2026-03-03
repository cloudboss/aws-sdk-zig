/// Provides details on a container instance bind mount host volume.
pub const AwsEcsTaskVolumeHostDetails = struct {
    /// When the `host` parameter is used, specify a `sourcePath` to declare the
    /// path
    /// on the host container instance that's presented to the container.
    source_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .source_path = "SourcePath",
    };
};
