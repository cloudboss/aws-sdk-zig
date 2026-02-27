const RedshiftDatabase = @import("redshift_database.zig").RedshiftDatabase;

/// Describes the `DataSource` details specific to Amazon Redshift.
pub const RedshiftMetadata = struct {
    database_user_name: ?[]const u8,

    redshift_database: ?RedshiftDatabase,

    /// The SQL query that is specified during CreateDataSourceFromRedshift. Returns
    /// only if `Verbose` is true in GetDataSourceInput.
    select_sql_query: ?[]const u8,

    pub const json_field_names = .{
        .database_user_name = "DatabaseUserName",
        .redshift_database = "RedshiftDatabase",
        .select_sql_query = "SelectSqlQuery",
    };
};
