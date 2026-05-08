/// Contains information about the S3 Tables integration configuration for a
/// configuration
/// template.
pub const S3TablesIntegration = struct {
    /// The name of the S3 Tables datasource.
    datasource_name: ?[]const u8 = null,

    /// The type of the S3 Tables datasource.
    datasource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .datasource_name = "datasourceName",
        .datasource_type = "datasourceType",
    };
};
