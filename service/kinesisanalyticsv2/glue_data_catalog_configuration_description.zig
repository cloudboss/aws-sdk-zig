/// The configuration of the Glue Data Catalog that you use for Apache Flink SQL
/// queries and table API transforms that you write in an application.
pub const GlueDataCatalogConfigurationDescription = struct {
    /// The Amazon Resource Name (ARN) of the database.
    database_arn: []const u8,

    pub const json_field_names = .{
        .database_arn = "DatabaseARN",
    };
};
