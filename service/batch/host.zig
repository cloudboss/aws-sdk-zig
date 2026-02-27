/// Determine whether your data volume persists on the host container instance
/// and where it's
/// stored. If this parameter is empty, then the Docker daemon assigns a host
/// path for your data
/// volume. However, the data isn't guaranteed to persist after the containers
/// that are associated
/// with it stop running.
pub const Host = struct {
    /// The path on the host container instance that's presented to the container.
    /// If this parameter
    /// is empty, then the Docker daemon has assigned a host path for you. If this
    /// parameter contains a
    /// file location, then the data volume persists at the specified location on
    /// the host container
    /// instance until you delete it manually. If the source path location doesn't
    /// exist on the host
    /// container instance, the Docker daemon creates it. If the location does
    /// exist, the contents of the
    /// source path folder are exported.
    ///
    /// This parameter isn't applicable to jobs that run on Fargate resources. Don't
    /// provide this
    /// for these jobs.
    source_path: ?[]const u8,

    pub const json_field_names = .{
        .source_path = "sourcePath",
    };
};
