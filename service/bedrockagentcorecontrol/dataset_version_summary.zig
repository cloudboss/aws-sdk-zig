/// Summary information about a published dataset version.
pub const DatasetVersionSummary = struct {
    /// The timestamp when this version was published.
    created_at: i64,

    /// The version number of this published snapshot.
    dataset_version: []const u8,

    /// The number of examples in this version.
    example_count: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .dataset_version = "datasetVersion",
        .example_count = "exampleCount",
    };
};
