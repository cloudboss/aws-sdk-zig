/// The parameters that are required to connect to a Google BigQuery data
/// source.
pub const BigQueryParameters = struct {
    /// The storage location where you create a Google BigQuery data source.
    data_set_region: ?[]const u8,

    /// The Google Cloud Platform project ID where your datasource was created.
    project_id: []const u8,

    pub const json_field_names = .{
        .data_set_region = "DataSetRegion",
        .project_id = "ProjectId",
    };
};
