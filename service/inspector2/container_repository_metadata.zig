/// Contains metadata about a container repository associated with a covered
/// resource.
pub const ContainerRepositoryMetadata = struct {
    /// The name of the container repository.
    name: ?[]const u8 = null,

    /// The scan frequency for the container repository.
    scan_frequency: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .scan_frequency = "scanFrequency",
    };
};
