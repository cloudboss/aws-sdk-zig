/// Configuration information for coordination with Glue, a fully managed
/// extract, transform
/// and load (ETL) service.
pub const GlueConfiguration = struct {
    /// The name of the database in your Glue Data Catalog in which the table is
    /// located. An
    /// Glue Data Catalog database contains metadata tables.
    database_name: []const u8,

    /// The name of the table in your Glue Data Catalog that is used to perform the
    /// ETL
    /// operations. An Glue Data Catalog table contains partitioned data and
    /// descriptions of data
    /// sources and targets.
    table_name: []const u8,

    pub const json_field_names = .{
        .database_name = "databaseName",
        .table_name = "tableName",
    };
};
