/// Data sources that are associated with an OpenSearch application.
pub const DataSource = struct {
    data_source_arn: ?[]const u8 = null,

    /// Detailed description of a data source.
    data_source_description: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_source_arn = "dataSourceArn",
        .data_source_description = "dataSourceDescription",
    };
};
