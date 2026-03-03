const JDBCConnectionType = @import("jdbc_connection_type.zig").JDBCConnectionType;
const GlueSchema = @import("glue_schema.zig").GlueSchema;

/// Specifies the direct JDBC source connection.
pub const DirectJDBCSource = struct {
    /// The connection name of the JDBC source.
    connection_name: []const u8,

    /// The connection type of the JDBC source.
    connection_type: JDBCConnectionType,

    /// The database of the JDBC source connection.
    database: []const u8,

    /// The name of the JDBC source connection.
    name: []const u8,

    /// Specifies the data schema for the direct JDBC source.
    output_schemas: ?[]const GlueSchema = null,

    /// The temp directory of the JDBC Redshift source.
    redshift_tmp_dir: ?[]const u8 = null,

    /// The table of the JDBC source connection.
    table: []const u8,

    pub const json_field_names = .{
        .connection_name = "ConnectionName",
        .connection_type = "ConnectionType",
        .database = "Database",
        .name = "Name",
        .output_schemas = "OutputSchemas",
        .redshift_tmp_dir = "RedshiftTmpDir",
        .table = "Table",
    };
};
