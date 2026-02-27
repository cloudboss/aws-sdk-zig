/// Updates to the configuration of the Glue Data Catalog that you use for SQL
/// queries that you write in a Managed Service for Apache Flink Studio
/// notebook.
pub const GlueDataCatalogConfigurationUpdate = struct {
    /// The updated Amazon Resource Name (ARN) of the database.
    database_arn_update: []const u8,

    pub const json_field_names = .{
        .database_arn_update = "DatabaseARNUpdate",
    };
};
